import 'package:equatable/equatable.dart';
import 'document_file.dart';

class HistoryGroup extends Equatable {
  final String title;
  final List<DocumentFile> files;
  const HistoryGroup(this.title, this.files);

  String get countLabel => '${files.length} ${files.length == 1 ? 'scan' : 'scans'}';

  @override
  List<Object?> get props => [title, files];
}
