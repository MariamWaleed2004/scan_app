import '../models/document_model.dart';
import '../models/project_summary_model.dart';
import '../models/storage_usage_model.dart';

/// In-memory sample data for Home. Replace with `DocumentsRemoteDataSource` (Dio) when the API is ready.
class DocumentsMockDataSource {
  Future<List<DocumentModel>> getRecentFiles() async {
    final now = DateTime.now();
    String at(int daysAgo, int hour, int minute) =>
        DateTime(now.year, now.month, now.day - daysAgo, hour, minute).toIso8601String();
    return [
      DocumentModel(
          id: 'sample-1', name: 'Contract_Villa_AlNakheel_Signed.pdf', category: 'architecture',
          sizeMb: 2.4, createdAt: at(0, 11, 20)),
      DocumentModel(
          id: 'sample-2', name: 'Structural_Inspection_Report_v2.pdf', category: 'inspections',
          sizeMb: 5.1, createdAt: at(1, 16, 45)),
      DocumentModel(
          id: 'sample-3', name: 'Municipality_Permits_2025.pdf', category: 'legal',
          sizeMb: 1.8, createdAt: DateTime(2025, 5, 12).toIso8601String()),
    ];
  }

  Future<ProjectSummaryModel> getFeaturedProject() async => const ProjectSummaryModel(
        name: 'Al-Nakheel Masterplan 2025',
        blueprintCount: 48,
        synced: '6m ago',
        memberInitials: ['T', 'S'],
      );

  Future<StorageUsageModel> getVaultUsage() async => const StorageUsageModel(usedGb: 14.8, totalGb: 50);
  Future<StorageUsageModel> getCloudUsage() async => const StorageUsageModel(usedGb: 3.4, totalGb: 15);
}
