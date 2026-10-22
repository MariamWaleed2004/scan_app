import 'folder_category.dart';

class DocumentFile {
  final String id;
  final String name;
  final FolderCategory category;
  final double sizeMb;
  final String modifiedLabel; // e.g. "Today, 11:20 AM"
  final String timeLabel; // e.g. "11:20 AM" (empty if unknown)

  const DocumentFile({
    required this.id,
    required this.name,
    required this.category,
    required this.sizeMb,
    required this.modifiedLabel,
    this.timeLabel = '',
  });

  String get sizeLabel => '$sizeMb MB';
}
