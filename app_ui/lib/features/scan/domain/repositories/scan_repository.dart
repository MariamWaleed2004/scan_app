import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../entities/scanned_document.dart';

abstract class ScanRepository {
  /// Combines the captured page images (in order) into one PDF and saves it.
  Future<Either<Failure, ScannedDocument>> savePdf({
    required List<String> imagePaths,
    required FolderCategory category,
  });
}
