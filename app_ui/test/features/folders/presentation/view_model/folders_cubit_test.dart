import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_cloud_usage.dart';
import 'package:fekra_house/features/folders/domain/entities/folder.dart';
import 'package:fekra_house/features/folders/domain/use_cases/get_folders.dart';
import 'package:fekra_house/features/folders/presentation/view_model/folders_cubit.dart';
import 'package:fekra_house/features/folders/presentation/view_model/folders_state.dart';

class MockGetFolders extends Mock implements GetFolders {}

class MockGetCloudUsage extends Mock implements GetCloudUsage {}

void main() {
  late MockGetFolders getFolders;
  late MockGetCloudUsage getCloudUsage;

  const cloud = StorageUsage(3.4, 15);
  const folders = [Folder('Legal & Permits', 14, 'May 10', FolderCategory.legal)];

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    getFolders = MockGetFolders();
    getCloudUsage = MockGetCloudUsage();
    when(() => getCloudUsage(any())).thenAnswer((_) async => const Right(cloud));
  });

  FoldersCubit build() => FoldersCubit(getFolders: getFolders, getCloudUsage: getCloudUsage);

  blocTest<FoldersCubit, FoldersState>(
    'emits success with folders and cloud usage',
    setUp: () => when(() => getFolders(any())).thenAnswer((_) async => const Right(folders)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      FoldersState(status: FoldersStatus.loading),
      FoldersState(status: FoldersStatus.success, folders: folders, cloudUsage: cloud),
    ],
  );

  blocTest<FoldersCubit, FoldersState>(
    'emits empty when there are no folders',
    setUp: () => when(() => getFolders(any())).thenAnswer((_) async => const Right(<Folder>[])),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      FoldersState(status: FoldersStatus.loading),
      FoldersState(status: FoldersStatus.empty, cloudUsage: cloud),
    ],
  );

  blocTest<FoldersCubit, FoldersState>(
    'emits failure when loading folders fails',
    setUp: () => when(() => getFolders(any())).thenAnswer((_) async => const Left(ServerFailure('Offline'))),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      FoldersState(status: FoldersStatus.loading),
      FoldersState(status: FoldersStatus.failure, errorMessage: 'Offline'),
    ],
  );
}
