import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import '../../../domain/entities/scanned_document.dart';
import '../../view_model/scan_cubit.dart';
import '../../view_model/scan_state.dart';
import '../widgets/camera_viewfinder.dart';
import '../widgets/scan_capture_controls.dart';
import '../widgets/scan_folder_chip.dart';
import '../widgets/scan_frame_overlay.dart';

/// Owns the camera (a widget-lifecycle resource, like a TextEditingController).
/// Captured pages, the target folder and saving are handled by [ScanCubit].
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  CameraController? _camera;
  String? _cameraError;
  bool _initializing = false;
  bool _capturing = false;
  FlashMode _flash = FlashMode.off;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _camera?.dispose();
    super.dispose();
  }

  /// Release the camera when the app goes to the background; restart it on return.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      final camera = _camera;
      if (camera == null) return;
      setState(() => _camera = null);
      camera.dispose();
    } else if (state == AppLifecycleState.resumed && _camera == null && _cameraError == null) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    if (_initializing) return;
    _initializing = true;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw CameraException('NoCamera', 'No camera was found on this device.');
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      try {
        await controller.setFlashMode(_flash);
      } on CameraException {
        // Some devices have no flash; ignore.
      }
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _camera = controller;
        _cameraError = null;
      });
    } on CameraException catch (e) {
      if (mounted) setState(() => _cameraError = _describe(e));
    } catch (_) {
      if (mounted) setState(() => _cameraError = 'The camera is not available on this device.');
    } finally {
      _initializing = false;
    }
  }

  void _retryCamera() {
    setState(() => _cameraError = null);
    _initCamera();
  }

  String _describe(CameraException e) => switch (e.code) {
        'CameraAccessDenied' ||
        'CameraAccessDeniedWithoutPrompt' ||
        'CameraAccessRestricted' =>
          'Camera access is denied. Allow camera permission for Fekra House in your device settings.',
        _ => e.description ?? 'Could not start the camera.',
      };

  Future<void> _capture() async {
    final camera = _camera;
    if (camera == null || !camera.value.isInitialized || _capturing || camera.value.isTakingPicture) return;
    setState(() => _capturing = true);
    try {
      final photo = await camera.takePicture();
      if (mounted) context.read<ScanCubit>().addPage(photo.path);
    } on CameraException catch (e) {
      if (mounted) _snack(e.description ?? 'Could not take the picture.');
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  Future<void> _toggleFlash() async {
    final camera = _camera;
    if (camera == null) return;
    final next = _flash == FlashMode.off ? FlashMode.always : FlashMode.off;
    try {
      await camera.setFlashMode(next);
      if (mounted) setState(() => _flash = next);
    } on CameraException {
      if (mounted) _snack('Flash is not available on this camera.');
    }
  }

  void _snack(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  void _onStateChanged(BuildContext context, ScanState state) {
    if (state.saveStatus == ScanSaveStatus.saved && state.savedDocument != null) {
      _showSavedDialog(state.savedDocument!);
    } else if (state.saveStatus == ScanSaveStatus.failure && state.errorMessage != null) {
      _snack(state.errorMessage!);
    }
  }

  Future<void> _showSavedDialog(ScannedDocument document) {
    final cubit = context.read<ScanCubit>();
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('PDF saved', style: ts(19, w: FontWeight.w800, c: AppColors.teal)),
        content: Text(
          '${document.name}\n${document.pagesLabel} • ${document.sizeLabel}\nFolder: ${document.category.title}',
          style: ts(13.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Scan more', style: ts(14, w: FontWeight.w700, c: Colors.black54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.openSavedPdf();
            },
            child: Text('Open PDF', style: ts(14, w: FontWeight.w700, c: AppColors.teal)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: Text('Done', style: ts(14, w: FontWeight.w800, c: AppColors.coral)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cameraReady = _camera?.value.isInitialized ?? false;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // white status-bar icons over the camera
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<ScanCubit, ScanState>(
          listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
          listener: _onStateChanged,
          builder: (context, state) {
            final cubit = context.read<ScanCubit>();
            return Stack(children: [
              // 1. Camera fills the entire screen, behind everything.
              Positioned.fill(
                child: CameraViewfinder(controller: _camera, error: _cameraError, onRetry: _retryCamera),
              ),
              // 2. Controls float on top, kept clear of the notch / home bar.
              SafeArea(
                bottom: false,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 30),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(child: ScanFolderChip(category: state.category, onChanged: cubit.setCategory)),
                      ),
                      IconButton(
                        tooltip: 'Flash',
                        onPressed: cameraReady ? _toggleFlash : null,
                        icon: Icon(
                          _flash == FlashMode.off ? Icons.flash_off : Icons.flash_on,
                          color: _flash == FlashMode.off ? Colors.white : AppColors.coral,
                          size: 28,
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: cameraReady && _cameraError == null
                        ? ScanFrameOverlay(
                            hint: state.pages.isEmpty
                                ? 'Fit the page inside the frame'
                                : 'Ready for page ${state.pages.length + 1}',
                          )
                        : const SizedBox.shrink(),
                  ),
                  ScanCaptureControls(
                    pages: state.pages,
                    onRemovePage: cubit.removePage,
                    onCapture: cameraReady && !_capturing && !state.isSaving ? _capture : null,
                    onSave: state.canSave ? cubit.save : null,
                    saving: state.isSaving,
                  ),
                  // Space for the phone's home indicator, under the gradient.
                  Container(height: MediaQuery.paddingOf(context).bottom, color: Colors.black87),
                ]),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
