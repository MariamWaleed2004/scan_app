import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../entities/document_file.dart';
import '../entities/project_summary.dart';
import '../entities/storage_usage.dart';

abstract class DocumentsRepository {
  Future<Either<Failure, List<DocumentFile>>> getRecentFiles();

  /// Documents saved on this device (e.g. scans), newest first.
  Future<Either<Failure, List<DocumentFile>>> getSavedDocuments();

  /// Stores a new document so it survives app restarts.
  Future<Either<Failure, Unit>> addDocument(DocumentFile document);

  /// Emits whenever the saved documents change.
  Stream<void> get changes;

  Future<Either<Failure, ProjectSummary>> getFeaturedProject();
  Future<Either<Failure, StorageUsage>> getVaultUsage();
  Future<Either<Failure, StorageUsage>> getCloudUsage();
}
