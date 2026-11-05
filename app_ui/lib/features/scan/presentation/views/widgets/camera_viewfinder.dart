import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Full-bleed live camera preview (cover-fit). Shows a loader while the camera
/// starts and a retry message if it can't.
class CameraViewfinder extends StatelessWidget {
  final CameraController? controller;
  final String? error;
  final VoidCallback onRetry;

  const CameraViewfinder({super.key, required this.controller, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) => ColoredBox(color: const Color(0xFF1F323F), child: _content());

  Widget _content() {
    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.no_photography_outlined, color: Colors.white70, size: 44),
            const SizedBox(height: 12),
            Text(error!, textAlign: TextAlign.center, style: ts(14, c: Colors.white)),
            const SizedBox(height: 10),
            TextButton(
              onPressed: onRetry,
              child: Text('Try again', style: ts(14, w: FontWeight.w800, c: AppColors.coral)),
            ),
          ]),
        ),
      );
    }
    final c = controller;
    if (c == null || !c.value.isInitialized) {
      return const Center(child: CircularProgressIndicator(color: AppColors.coral));
    }
    final size = c.value.previewSize;
    if (size == null) return CameraPreview(c);
    // previewSize is reported in landscape; swap it for a portrait, cover-fit preview.
    return SizedBox.expand(
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(width: size.height, height: size.width, child: CameraPreview(c)),
        ),
      ),
    );
  }
}
