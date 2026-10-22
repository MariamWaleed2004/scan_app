import '../../domain/entities/document_file.dart';
import '../../domain/entities/folder_category.dart';

class DocumentModel extends DocumentFile {
  const DocumentModel({
    required super.id,
    required super.name,
    required super.category,
    required super.sizeMb,
    required super.modifiedLabel,
    super.timeLabel,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> j) => DocumentModel(
        id: j['id'] as String,
        name: j['name'] as String,
        category: FolderCategory.values.byName(j['category'] as String),
        sizeMb: (j['size_mb'] as num).toDouble(),
        modifiedLabel: j['modified'] as String,
        timeLabel: (j['time'] as String?) ?? '',
      );
}
