import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import '../../domain/entities/folder.dart';

class FolderModel {
  final String name;
  final int fileCount;
  final String lastActivity;
  final String category; // FolderCategory name as sent by the API

  const FolderModel({
    required this.name,
    required this.fileCount,
    required this.lastActivity,
    required this.category,
  });

  factory FolderModel.fromJson(Map<String, dynamic> j) => FolderModel(
        name: j['name'] as String,
        fileCount: j['file_count'] as int,
        lastActivity: j['last_activity'] as String,
        category: j['category'] as String,
      );

  Folder toEntity() => Folder(name, fileCount, lastActivity, FolderCategory.values.byName(category));
}
