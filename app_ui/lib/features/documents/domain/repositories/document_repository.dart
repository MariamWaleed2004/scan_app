import '../entities/document_file.dart';
import '../entities/history_group.dart';
import '../entities/project_summary.dart';
import '../entities/storage_usage.dart';

abstract class DocumentRepository {
  Future<List<DocumentFile>> getRecentFiles();
  Future<List<HistoryGroup>> getHistory();
  Future<ProjectSummary> getFeaturedProject();
  Future<StorageUsage> getVaultUsage();
  Future<StorageUsage> getCloudUsage();
}
