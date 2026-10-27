import '../../domain/entities/document_file.dart';
import '../../domain/entities/folder_category.dart';

class DocumentModel {
  final String id;
  final String name;
  final String category; // FolderCategory name as sent by the API
  final double sizeMb;
  final String modified;
  final String time;

  const DocumentModel({
    required this.id,
    required this.name,
    required this.category,
    required this.sizeMb,
    required this.modified,
    this.time = '',
  });

  factory DocumentModel.fromJson(Map<String, dynamic> j) => DocumentModel(
        id: j['id'] as String,
        name: j['name'] as String,
        category: j['category'] as String,
        sizeMb: (j['size_mb'] as num).toDouble(),
        modified: j['modified'] as String,
        time: (j['time'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'category': category, 'size_mb': sizeMb, 'modified': modified, 'time': time};

  DocumentFile toEntity() => DocumentFile(
        id: id,
        name: name,
        category: FolderCategory.values.byName(category),
        sizeMb: sizeMb,
        modifiedLabel: modified,
        timeLabel: time,
      );
}
