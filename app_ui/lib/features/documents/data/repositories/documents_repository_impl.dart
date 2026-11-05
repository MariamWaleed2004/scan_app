import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failure_guard.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../../domain/entities/document_file.dart';
import '../../domain/entities/project_summary.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/documents_repository.dart';
import '../data_sources/documents_local_data_source.dart';
import '../data_sources/documents_mock_data_source.dart';
import '../models/document_model.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  final DocumentsMockDataSource _mock;
  final DocumentsLocalDataSource _local;

  const DocumentsRepositoryImpl({required DocumentsMockDataSource mock, required DocumentsLocalDataSource local})
      : _mock = mock,
        _local = local;

  @override
  Future<Either<Failure, List<DocumentFile>>> getRecentFiles() =>
      guardFailure(() async => (await _mock.getRecentFiles()).map((m) => m.toEntity()).toList());

  @override
  Future<Either<Failure, List<DocumentFile>>> getSavedDocuments() =>
      guardFailure(() async => (await _local.getSavedDocuments()).map((m) => m.toEntity()).toList());

  @override
  Future<Either<Failure, Unit>> addDocument(DocumentFile document) => guardFailure(() async {
        await _local.addDocument(DocumentModel.fromEntity(document));
        return unit;
      });

  @override
  Stream<void> get changes => _local.changes;

  @override
  Future<Either<Failure, ProjectSummary>> getFeaturedProject() =>
      guardFailure(() async => (await _mock.getFeaturedProject()).toEntity());

  @override
  Future<Either<Failure, StorageUsage>> getVaultUsage() =>
      guardFailure(() async => (await _mock.getVaultUsage()).toEntity());

  @override
  Future<Either<Failure, StorageUsage>> getCloudUsage() =>
      guardFailure(() async => (await _mock.getCloudUsage()).toEntity());
}
