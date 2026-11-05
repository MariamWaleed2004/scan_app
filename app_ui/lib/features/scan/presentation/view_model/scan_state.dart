import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../../domain/entities/scanned_document.dart';

enum ScanSaveStatus { idle, saving, saved, failure }

class ScanState extends Equatable {
  /// Captured page images, in page order.
  final List<String> pages;
  final FolderCategory category;
  final ScanSaveStatus saveStatus;
  final ScannedDocument? savedDocument;
  final String? errorMessage;

  const ScanState({
    this.pages = const [],
    this.category = FolderCategory.architecture,
    this.saveStatus = ScanSaveStatus.idle,
    this.savedDocument,
    this.errorMessage,
  });

  bool get isSaving => saveStatus == ScanSaveStatus.saving;
  bool get canSave => pages.isNotEmpty && !isSaving;

  ScanState copyWith({
    List<String>? pages,
    FolderCategory? category,
    ScanSaveStatus? saveStatus,
    ScannedDocument? savedDocument,
    String? errorMessage,
  }) =>
      ScanState(
        pages: pages ?? this.pages,
        category: category ?? this.category,
        saveStatus: saveStatus ?? this.saveStatus,
        savedDocument: savedDocument ?? this.savedDocument,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [pages, category, saveStatus, savedDocument, errorMessage];
}
