import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

/// A PDF produced from scanned pages.
class ScannedDocument extends Equatable {
  final String name;
  final String filePath;
  final int pageCount;
  final double sizeMb;
  final DateTime createdAt;
  final FolderCategory category;

  const ScannedDocument({
    required this.name,
    required this.filePath,
    required this.pageCount,
    required this.sizeMb,
    required this.createdAt,
    required this.category,
  });

  String get sizeLabel => '${sizeMb.toStringAsFixed(1)} MB';
  String get pagesLabel => '$pageCount ${pageCount == 1 ? 'page' : 'pages'}';

  @override
  List<Object?> get props => [name, filePath, pageCount, sizeMb, createdAt, category];
}
