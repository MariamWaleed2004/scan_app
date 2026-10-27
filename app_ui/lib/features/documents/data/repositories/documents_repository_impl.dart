import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failure_guard.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../../domain/entities/document_file.dart';
import '../../domain/entities/history_group.dart';
import '../../domain/entities/project_summary.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/documents_repository.dart';
import '../data_sources/documents_mock_data_source.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  final DocumentsMockDataSource _source;
  const DocumentsRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<DocumentFile>>> getRecentFiles() =>
      guardFailure(() async => (await _source.getRecentFiles()).map((m) => m.toEntity()).toList());

  @override
  Future<Either<Failure, List<HistoryGroup>>> getHistory() =>
      guardFailure(() async => (await _source.getHistory()).map((m) => m.toEntity()).toList());

  @override
  Future<Either<Failure, ProjectSummary>> getFeaturedProject() =>
      guardFailure(() async => (await _source.getFeaturedProject()).toEntity());

  @override
  Future<Either<Failure, StorageUsage>> getVaultUsage() =>
      guardFailure(() async => (await _source.getVaultUsage()).toEntity());

  @override
  Future<Either<Failure, StorageUsage>> getCloudUsage() =>
      guardFailure(() async => (await _source.getCloudUsage()).toEntity());
}
