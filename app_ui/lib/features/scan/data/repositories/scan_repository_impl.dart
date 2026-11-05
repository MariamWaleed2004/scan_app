import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failure_guard.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../../domain/entities/scanned_document.dart';
import '../../domain/repositories/scan_repository.dart';
import '../data_sources/scan_pdf_local_data_source.dart';

class ScanRepositoryImpl implements ScanRepository {
  final ScanPdfLocalDataSource _source;
  const ScanRepositoryImpl(this._source);

  @override
  Future<Either<Failure, ScannedDocument>> savePdf({
    required List<String> imagePaths,
    required FolderCategory category,
  }) =>
      guardFailure(
          () async => (await _source.savePdf(imagePaths: imagePaths, category: category.name)).toEntity());
}
