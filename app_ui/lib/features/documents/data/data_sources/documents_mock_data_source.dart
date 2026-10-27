import '../models/document_model.dart';
import '../models/history_group_model.dart';
import '../models/project_summary_model.dart';
import '../models/storage_usage_model.dart';

/// In-memory mock. Replace with `DocumentsRemoteDataSource` (Dio) when the API is ready.
class DocumentsMockDataSource {
  static const _contract = DocumentModel(
      id: '1', name: 'Contract_Villa_AlNakheel_Signed.pdf', category: 'architecture',
      sizeMb: 2.4, modified: 'Today, 11:20 AM', time: '11:20 AM');
  static const _photos = DocumentModel(
      id: '2', name: 'Site_Photos_Foundation_Check.pdf', category: 'inspections',
      sizeMb: 4.8, modified: 'Today, 09:15 AM', time: '09:15 AM');
  static const _report = DocumentModel(
      id: '3', name: 'Structural_Inspection_Report_v2.pdf', category: 'inspections',
      sizeMb: 5.1, modified: 'Yesterday, 4:45 PM', time: '4:45 PM');
  static const _vendor = DocumentModel(
      id: '4', name: 'Vendor_Agreement_Draft.pdf', category: 'legal',
      sizeMb: 1.2, modified: 'Yesterday, 02:10 PM', time: '02:10 PM');
  static const _permits = DocumentModel(
      id: '5', name: 'Municipality_Permits_2025.pdf', category: 'legal',
      sizeMb: 1.8, modified: 'May 12, 2025');

  Future<List<DocumentModel>> getRecentFiles() async => const [_contract, _report, _permits];

  Future<List<HistoryGroupModel>> getHistory() async => const [
        HistoryGroupModel(title: 'Today', files: [_contract, _photos]),
        HistoryGroupModel(title: 'Yesterday', files: [_report, _vendor]),
        HistoryGroupModel(title: 'May 12, 2025', files: [_permits]),
      ];

  Future<ProjectSummaryModel> getFeaturedProject() async => const ProjectSummaryModel(
        name: 'Al-Nakheel Masterplan 2025',
        blueprintCount: 48,
        synced: '6m ago',
        memberInitials: ['T', 'S'],
      );

  Future<StorageUsageModel> getVaultUsage() async => const StorageUsageModel(usedGb: 14.8, totalGb: 50);
  Future<StorageUsageModel> getCloudUsage() async => const StorageUsageModel(usedGb: 3.4, totalGb: 15);
}
