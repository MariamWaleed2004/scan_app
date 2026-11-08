import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/services/files/file_opener.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../../domain/use_cases/save_scan_as_pdf.dart';
import 'scan_state.dart';

/// Holds the scanning session (captured pages, target folder) and saves it as a PDF.
/// The camera itself stays in the screen: it's a widget-lifecycle resource.
class ScanCubit extends Cubit<ScanState> {
  final SaveScanAsPdf _saveScanAsPdf;
  final FileOpener _fileOpener;

  ScanCubit({required SaveScanAsPdf saveScanAsPdf, required FileOpener fileOpener})
      : _saveScanAsPdf = saveScanAsPdf,
        _fileOpener = fileOpener,
        super(const ScanState());

  void addPage(String imagePath) =>
      emit(state.copyWith(pages: [...state.pages, imagePath], saveStatus: ScanSaveStatus.idle));

  void removePage(int index) {
    if (index < 0 || index >= state.pages.length) return;
    emit(state.copyWith(pages: [...state.pages]..removeAt(index), saveStatus: ScanSaveStatus.idle));
  }

  void setCategory(FolderCategory category) => emit(state.copyWith(category: category));

  Future<void> save() async {
    if (!state.canSave) return;
    emit(state.copyWith(saveStatus: ScanSaveStatus.saving));

    final result = await _saveScanAsPdf(SaveScanParams(imagePaths: state.pages, category: state.category));

    result.fold(
      (failure) => emit(state.copyWith(saveStatus: ScanSaveStatus.failure, errorMessage: failure.message)),
      (document) => emit(state.copyWith(pages: const [], saveStatus: ScanSaveStatus.saved, savedDocument: document)),
    );
  }

  Future<void> openSavedPdf() async {
    final document = state.savedDocument;
    if (document == null) return;
    final opened = await _fileOpener.open(document.filePath);
    if (!opened) {
      emit(state.copyWith(saveStatus: ScanSaveStatus.failure, errorMessage: 'No app found to open PDF files.'));
    }
  }
}
