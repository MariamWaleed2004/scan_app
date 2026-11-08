import '../models/folder_model.dart';

/// In-memory mock. Replace with `FoldersRemoteDataSource` (Dio) when the API is ready.
class FoldersMockDataSource {
  Future<List<FolderModel>> getFolders() async => const [
        FolderModel(name: 'Architecture Projects', fileCount: 18, lastActivity: '2 hrs ago', category: 'architecture'),
        FolderModel(name: 'Site Inspections', fileCount: 9, lastActivity: 'Yesterday', category: 'inspections'),
        FolderModel(name: 'Legal & Permits', fileCount: 14, lastActivity: 'May 10', category: 'legal'),
        FolderModel(name: 'Financial Invoices', fileCount: 6, lastActivity: 'Apr 28', category: 'financial'),
      ];
}
