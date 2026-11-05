import '../../domain/entities/document_file.dart';
import '../../domain/entities/folder_category.dart';

class DocumentModel {
  final String id;
  final String name;
  final String category; // FolderCategory name
  final double sizeMb;
  final String createdAt; // ISO-8601
  final String? filePath;

  const DocumentModel({
    required this.id,
    required this.name,
    required this.category,
    required this.sizeMb,
    required this.createdAt,
    this.filePath,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> j) => DocumentModel(
        id: j['id'] as String,
        name: j['name'] as String,
        category: j['category'] as String,
        sizeMb: (j['size_mb'] as num).toDouble(),
        createdAt: j['created_at'] as String,
        filePath: j['file_path'] as String?,
      );

  factory DocumentModel.fromEntity(DocumentFile e) => DocumentModel(
        id: e.id,
        name: e.name,
        category: e.category.name,
        sizeMb: e.sizeMb,
        createdAt: e.createdAt.toIso8601String(),
        filePath: e.filePath,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'size_mb': sizeMb,
        'created_at': createdAt,
        if (filePath != null) 'file_path': filePath,
      };

  DocumentModel withFilePath(String path) => DocumentModel(
        id: id,
        name: name,
        category: category,
        sizeMb: sizeMb,
        createdAt: createdAt,
        filePath: path,
      );

  DocumentFile toEntity() => DocumentFile(
        id: id,
        name: name,
        category: FolderCategory.values.byName(category),
        sizeMb: sizeMb,
        createdAt: DateTime.parse(createdAt),
        filePath: filePath,
      );
}
