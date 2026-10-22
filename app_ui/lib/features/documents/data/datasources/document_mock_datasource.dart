import '../../domain/entities/folder_category.dart';
import '../../domain/entities/history_group.dart';
import '../../domain/entities/project_summary.dart';
import '../../domain/entities/storage_usage.dart';
import '../models/document_model.dart';

/// Mock data source. Replace with API / local DB implementation.
class DocumentMockDataSource {
  static const _contract = DocumentModel(
      id: '1', name: 'Contract_Villa_AlNakheel_Signed.pdf', category: FolderCategory.architecture,
      sizeMb: 2.4, modifiedLabel: 'Today, 11:20 AM', timeLabel: '11:20 AM');
  static const _photos = DocumentModel(
      id: '2', name: 'Site_Photos_Foundation_Check.pdf', category: FolderCategory.inspections,
      sizeMb: 4.8, modifiedLabel: 'Today, 09:15 AM', timeLabel: '09:15 AM');
  static const _report = DocumentModel(
      id: '3', name: 'Structural_Inspection_Report_v2.pdf', category: FolderCategory.inspections,
      sizeMb: 5.1, modifiedLabel: 'Yesterday, 4:45 PM', timeLabel: '4:45 PM');
  static const _vendor = DocumentModel(
      id: '4', name: 'Vendor_Agreement_Draft.pdf', category: FolderCategory.legal,
      sizeMb: 1.2, modifiedLabel: 'Yesterday, 02:10 PM', timeLabel: '02:10 PM');
  static const _permits = DocumentModel(
      id: '5', name: 'Municipality_Permits_2025.pdf', category: FolderCategory.legal,
      sizeMb: 1.8, modifiedLabel: 'May 12, 2025');

  Future<List<DocumentModel>> recentFiles() async => [_contract, _report, _permits];

  Future<List<HistoryGroup>> history() async => [
        HistoryGroup('Today', [_contract, _photos]),
        HistoryGroup('Yesterday', [_report, _vendor]),
        HistoryGroup('May 12, 2025', [_permits]),
      ];

  Future<ProjectSummary> featuredProject() async => const ProjectSummary(
        name: 'Al-Nakheel Masterplan 2025',
        blueprintCount: 48,
        syncedLabel: '6m ago',
        memberInitials: ['T', 'S'],
      );

  Future<StorageUsage> vaultUsage() async => const StorageUsage(14.8, 50);
  Future<StorageUsage> cloudUsage() async => const StorageUsage(3.4, 15);
}
