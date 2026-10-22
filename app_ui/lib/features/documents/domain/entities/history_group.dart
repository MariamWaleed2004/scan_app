import 'document_file.dart';

class HistoryGroup {
  final String title;
  final List<DocumentFile> files;
  const HistoryGroup(this.title, this.files);

  String get countLabel => '${files.length} ${files.length == 1 ? 'scan' : 'scans'}';
}
