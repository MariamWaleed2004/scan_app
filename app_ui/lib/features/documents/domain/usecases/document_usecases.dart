import 'package:app_ui/core/usecase/usecase.dart';
import '../entities/document_file.dart';
import '../entities/history_group.dart';
import '../entities/project_summary.dart';
import '../entities/storage_usage.dart';
import '../repositories/document_repository.dart';

class GetRecentFiles implements UseCase<List<DocumentFile>, NoParams> {
  final DocumentRepository _r;
  const GetRecentFiles(this._r);
  @override
  Future<List<DocumentFile>> call(NoParams p) => _r.getRecentFiles();
}

class GetHistory implements UseCase<List<HistoryGroup>, NoParams> {
  final DocumentRepository _r;
  const GetHistory(this._r);
  @override
  Future<List<HistoryGroup>> call(NoParams p) => _r.getHistory();
}

class GetFeaturedProject implements UseCase<ProjectSummary, NoParams> {
  final DocumentRepository _r;
  const GetFeaturedProject(this._r);
  @override
  Future<ProjectSummary> call(NoParams p) => _r.getFeaturedProject();
}

class GetVaultUsage implements UseCase<StorageUsage, NoParams> {
  final DocumentRepository _r;
  const GetVaultUsage(this._r);
  @override
  Future<StorageUsage> call(NoParams p) => _r.getVaultUsage();
}

class GetCloudUsage implements UseCase<StorageUsage, NoParams> {
  final DocumentRepository _r;
  const GetCloudUsage(this._r);
  @override
  Future<StorageUsage> call(NoParams p) => _r.getCloudUsage();
}
