import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/services/files/file_opener.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/entities/history_group.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_history.dart';
import 'package:fekra_house/features/documents/domain/use_cases/watch_document_changes.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_cubit.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_state.dart';

class MockGetHistory extends Mock implements GetHistory {}

class MockWatchDocumentChanges extends Mock implements WatchDocumentChanges {}

class MockFileOpener extends Mock implements FileOpener {}

void main() {
  late MockGetHistory getHistory;
  late MockWatchDocumentChanges watchChanges;
  late MockFileOpener fileOpener;
  late StreamController<void> changes;

  final file = DocumentFile(
    id: 'Scan.pdf',
    name: 'Scan.pdf',
    category: FolderCategory.legal,
    sizeMb: 1.5,
    createdAt: DateTime(2026, 11, 5, 10),
    filePath: '/docs/scans/Scan.pdf',
  );
  final groups = [HistoryGroup('Today', [file])];

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    getHistory = MockGetHistory();
    watchChanges = MockWatchDocumentChanges();
    fileOpener = MockFileOpener();
    changes = StreamController<void>.broadcast();
    when(() => watchChanges()).thenAnswer((_) => changes.stream);
  });

  tearDown(() => changes.close());

  HistoryCubit build() =>
      HistoryCubit(getHistory: getHistory, watchDocumentChanges: watchChanges, fileOpener: fileOpener);

  blocTest<HistoryCubit, HistoryState>(
    'emits success when there are files',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => Right(groups)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      const HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.success, groups: groups),
    ],
    verify: (cubit) {
      expect(cubit.state.totalMb, 1.5);
      expect(cubit.state.projectCount, 1);
    },
  );

  blocTest<HistoryCubit, HistoryState>(
    'emits empty when there are no saved documents',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => const Right(<HistoryGroup>[])),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.empty),
    ],
  );

  blocTest<HistoryCubit, HistoryState>(
    'emits failure on error',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => const Left(CacheFailure())),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.failure, errorMessage: 'Could not read local data.'),
    ],
  );

  blocTest<HistoryCubit, HistoryState>(
    'reloads quietly (no loader) when a document is saved',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => Right(groups)),
    build: build,
    act: (cubit) async {
      changes.add(null);
      await Future<void>.delayed(Duration.zero);
    },
    expect: () => [HistoryState(status: HistoryStatus.success, groups: groups)],
  );

  test('openDocument opens the file path', () async {
    when(() => fileOpener.open('/docs/scans/Scan.pdf')).thenAnswer((_) async => true);
    final cubit = build();

    expect(await cubit.openDocument(file), isTrue);
    await cubit.close();
  });
}
