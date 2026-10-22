import '../../domain/entities/document_file.dart';
import '../../domain/entities/history_group.dart';
import '../../domain/entities/project_summary.dart';
import '../../domain/entities/storage_usage.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_mock_datasource.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentMockDataSource _ds;
  const DocumentRepositoryImpl(this._ds);

  @override
  Future<List<DocumentFile>> getRecentFiles() => _ds.recentFiles();
  @override
  Future<List<HistoryGroup>> getHistory() => _ds.history();
  @override
  Future<ProjectSummary> getFeaturedProject() => _ds.featuredProject();
  @override
  Future<StorageUsage> getVaultUsage() => _ds.vaultUsage();
  @override
  Future<StorageUsage> getCloudUsage() => _ds.cloudUsage();
}
