import 'package:app_ui/features/documents/domain/entities/folder_category.dart';

class FolderEntity {
  final String name;
  final int fileCount;
  final String lastActivity;
  final FolderCategory category;
  const FolderEntity(this.name, this.fileCount, this.lastActivity, this.category);

  String get meta => '$fileCount files • $lastActivity';
}
