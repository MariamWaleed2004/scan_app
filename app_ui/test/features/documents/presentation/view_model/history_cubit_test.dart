import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/entities/history_group.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_history.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_cubit.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_state.dart';

class MockGetHistory extends Mock implements GetHistory {}

void main() {
  late MockGetHistory getHistory;

  const file = DocumentFile(id: '1', name: 'a.pdf', category: FolderCategory.legal, sizeMb: 1.5, modifiedLabel: 'Today');
  const groups = [HistoryGroup('Today', [file])];

  setUpAll(() => registerFallbackValue(const NoParams()));
  setUp(() => getHistory = MockGetHistory());

  blocTest<HistoryCubit, HistoryState>(
    'emits success when there are files',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => const Right(groups)),
    build: () => HistoryCubit(getHistory),
    act: (cubit) => cubit.load(),
    expect: () => const [
      HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.success, groups: groups),
    ],
    verify: (cubit) {
      expect(cubit.state.totalMb, 1.5);
      expect(cubit.state.projectCount, 1);
    },
  );

  blocTest<HistoryCubit, HistoryState>(
    'emits empty when every group has no files',
    setUp: () => when(() => getHistory(any()))
        .thenAnswer((_) async => const Right([HistoryGroup('Today', <DocumentFile>[])])),
    build: () => HistoryCubit(getHistory),
    act: (cubit) => cubit.load(),
    expect: () => const [
      HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.empty, groups: [HistoryGroup('Today', <DocumentFile>[])]),
    ],
  );

  blocTest<HistoryCubit, HistoryState>(
    'emits failure on error',
    setUp: () => when(() => getHistory(any())).thenAnswer((_) async => const Left(CacheFailure())),
    build: () => HistoryCubit(getHistory),
    act: (cubit) => cubit.load(),
    expect: () => const [
      HistoryState(status: HistoryStatus.loading),
      HistoryState(status: HistoryStatus.failure, errorMessage: 'Could not read local data.'),
    ],
  );
}
