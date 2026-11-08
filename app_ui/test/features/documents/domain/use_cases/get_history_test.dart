import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/entities/history_group.dart';
import 'package:fekra_house/features/documents/domain/repositories/documents_repository.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_history.dart';

class MockDocumentsRepository extends Mock implements DocumentsRepository {}

DocumentFile doc(String name, DateTime at) =>
    DocumentFile(id: name, name: name, category: FolderCategory.legal, sizeMb: 1, createdAt: at);

void main() {
  late MockDocumentsRepository repository;
  final now = DateTime(2026, 11, 5, 18);

  setUp(() => repository = MockDocumentsRepository());

  test('groups documents by day, newest day and newest file first', () async {
    final todayLate = doc('today-late', DateTime(2026, 11, 5, 15));
    final todayEarly = doc('today-early', DateTime(2026, 11, 5, 9));
    final yesterday = doc('yesterday', DateTime(2026, 11, 4, 12));
    final older = doc('older', DateTime(2025, 5, 12, 10));
    when(() => repository.getSavedDocuments())
        .thenAnswer((_) async => Right([older, todayEarly, yesterday, todayLate]));

    final result = await GetHistory(repository, now: () => now)(const NoParams());

    expect(result.getOrElse(() => const []), [
      HistoryGroup('Today', [todayLate, todayEarly]),
      HistoryGroup('Yesterday', [yesterday]),
      HistoryGroup('May 12, 2025', [older]),
    ]);
  });

  test('passes failures through', () async {
    when(() => repository.getSavedDocuments()).thenAnswer((_) async => const Left(CacheFailure('Disk error')));

    final result = await GetHistory(repository, now: () => now)(const NoParams());

    expect(result, const Left<Failure, List<HistoryGroup>>(CacheFailure('Disk error')));
  });
}
