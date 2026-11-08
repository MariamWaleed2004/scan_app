import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/core/utils/date_formatter.dart';
import '../entities/document_file.dart';
import '../entities/history_group.dart';
import '../repositories/documents_repository.dart';

/// Saved documents grouped by day ("Today", "Yesterday", "May 12, 2025"), newest first.
class GetHistory implements UseCase<List<HistoryGroup>, NoParams> {
  final DocumentsRepository _repository;
  final DateTime Function() _now;

  GetHistory(this._repository, {DateTime Function()? now}) : _now = now ?? DateTime.now;

  @override
  Future<Either<Failure, List<HistoryGroup>>> call(NoParams params) async =>
      (await _repository.getSavedDocuments()).map(_groupByDay);

  List<HistoryGroup> _groupByDay(List<DocumentFile> documents) {
    final now = _now();
    final sorted = [...documents]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final groups = <String, List<DocumentFile>>{}; // insertion order = newest day first
    for (final doc in sorted) {
      groups.putIfAbsent(DateFormatter.day(doc.createdAt, now: now), () => []).add(doc);
    }
    return [for (final entry in groups.entries) HistoryGroup(entry.key, entry.value)];
  }
}
