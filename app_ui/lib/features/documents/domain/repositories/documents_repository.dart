import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../entities/document_file.dart';
import '../entities/history_group.dart';
import '../entities/project_summary.dart';
import '../entities/storage_usage.dart';

abstract class DocumentsRepository {
  Future<Either<Failure, List<DocumentFile>>> getRecentFiles();
  Future<Either<Failure, List<HistoryGroup>>> getHistory();
  Future<Either<Failure, ProjectSummary>> getFeaturedProject();
  Future<Either<Failure, StorageUsage>> getVaultUsage();
  Future<Either<Failure, StorageUsage>> getCloudUsage();
}
