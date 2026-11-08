import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../../domain/entities/scanned_document.dart';

class ScannedDocumentModel {
  final String name;
  final String filePath;
  final int pageCount;
  final int sizeBytes;
  final String createdAt; // ISO-8601
  final String category; // FolderCategory name

  const ScannedDocumentModel({
    required this.name,
    required this.filePath,
    required this.pageCount,
    required this.sizeBytes,
    required this.createdAt,
    required this.category,
  });

  factory ScannedDocumentModel.fromJson(Map<String, dynamic> j) => ScannedDocumentModel(
        name: j['name'] as String,
        filePath: j['file_path'] as String,
        pageCount: j['page_count'] as int,
        sizeBytes: j['size_bytes'] as int,
        createdAt: j['created_at'] as String,
        category: j['category'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'file_path': filePath,
        'page_count': pageCount,
        'size_bytes': sizeBytes,
        'created_at': createdAt,
        'category': category,
      };

  ScannedDocument toEntity() => ScannedDocument(
        name: name,
        filePath: filePath,
        pageCount: pageCount,
        sizeMb: sizeBytes / (1024 * 1024),
        createdAt: DateTime.parse(createdAt),
        category: FolderCategory.values.byName(category),
      );
}
