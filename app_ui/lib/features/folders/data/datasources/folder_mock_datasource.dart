import 'package:app_ui/features/documents/domain/entities/folder_category.dart';
import '../../domain/entities/folder_entity.dart';

class FolderMockDataSource {
  Future<List<FolderEntity>> folders() async => const [
        FolderEntity('Architecture Projects', 18, '2 hrs ago', FolderCategory.architecture),
        FolderEntity('Site Inspections', 9, 'Yesterday', FolderCategory.inspections),
        FolderEntity('Legal & Permits', 14, 'May 10', FolderCategory.legal),
        FolderEntity('Financial Invoices', 6, 'Apr 28', FolderCategory.financial),
      ];
}
