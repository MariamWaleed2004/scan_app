import 'package:equatable/equatable.dart';
import 'folder_category.dart';

class DocumentFile extends Equatable {
  final String id;
  final String name;
  final FolderCategory category;
  final double sizeMb;
  final DateTime createdAt;

  /// Location of the file on this device; null for documents that only exist
  /// remotely (e.g. the sample data), which can't be opened.
  final String? filePath;

  const DocumentFile({
    required this.id,
    required this.name,
    required this.category,
    required this.sizeMb,
    required this.createdAt,
    this.filePath,
  });

  bool get canOpen => filePath != null;
  String get sizeLabel => '${sizeMb.toStringAsFixed(1)} MB';

  @override
  List<Object?> get props => [id, name, category, sizeMb, createdAt, filePath];
}
