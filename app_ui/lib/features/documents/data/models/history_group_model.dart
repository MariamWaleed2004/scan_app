import '../../domain/entities/history_group.dart';
import 'document_model.dart';

class HistoryGroupModel {
  final String title;
  final List<DocumentModel> files;
  const HistoryGroupModel({required this.title, required this.files});

  factory HistoryGroupModel.fromJson(Map<String, dynamic> j) => HistoryGroupModel(
        title: j['title'] as String,
        files: (j['files'] as List).map((e) => DocumentModel.fromJson(e as Map<String, dynamic>)).toList(),
      );

  HistoryGroup toEntity() => HistoryGroup(title, files.map((f) => f.toEntity()).toList());
}
