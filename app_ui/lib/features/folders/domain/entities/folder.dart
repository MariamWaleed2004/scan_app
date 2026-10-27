import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

class Folder extends Equatable {
  final String name;
  final int fileCount;
  final String lastActivity;
  final FolderCategory category;

  const Folder(this.name, this.fileCount, this.lastActivity, this.category);

  String get meta => '$fileCount files • $lastActivity';

  @override
  List<Object?> get props => [name, fileCount, lastActivity, category];
}
