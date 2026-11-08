import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/use_cases/add_document.dart';
import '../entities/scanned_document.dart';
import '../repositories/scan_repository.dart';

class SaveScanParams {
  final List<String> imagePaths;
  final FolderCategory category;
  const SaveScanParams({required this.imagePaths, required this.category});
}

/// Builds the PDF, then registers it as a document so it appears in History.
class SaveScanAsPdf implements UseCase<ScannedDocument, SaveScanParams> {
  final ScanRepository _scanRepository;
  final AddDocument _addDocument; // documents' domain owns the saved-documents list

  const SaveScanAsPdf(this._scanRepository, this._addDocument);

  @override
  Future<Either<Failure, ScannedDocument>> call(SaveScanParams p) async {
    // Business rule: a document needs at least one page.
    if (p.imagePaths.isEmpty) {
      return const Left(ValidationFailure('Capture at least one page before saving.'));
    }

    final saved = await _scanRepository.savePdf(imagePaths: p.imagePaths, category: p.category);

    return saved.fold<Future<Either<Failure, ScannedDocument>>>(
      (failure) async => Left(failure),
      (scan) async => (await _addDocument(_asDocument(scan))).map((_) => scan),
    );
  }

  DocumentFile _asDocument(ScannedDocument scan) => DocumentFile(
        id: scan.name,
        name: scan.name,
        category: scan.category,
        sizeMb: scan.sizeMb,
        createdAt: scan.createdAt,
        filePath: scan.filePath,
      );
}
