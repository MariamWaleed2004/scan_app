import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/get_current_user.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/project_summary.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_featured_project.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_recent_files.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_vault_usage.dart';
import 'package:fekra_house/features/home/presentation/view_model/home_cubit.dart';
import 'package:fekra_house/features/home/presentation/view_model/home_state.dart';

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockGetFeaturedProject extends Mock implements GetFeaturedProject {}

class MockGetRecentFiles extends Mock implements GetRecentFiles {}

class MockGetVaultUsage extends Mock implements GetVaultUsage {}

void main() {
  late MockGetCurrentUser getCurrentUser;
  late MockGetFeaturedProject getFeaturedProject;
  late MockGetRecentFiles getRecentFiles;
  late MockGetVaultUsage getVaultUsage;

  const none = NoParams();
  const user = User(fullName: 'Tariq Mansour', title: 'Architect', phone: 'p', organization: 'o');
  const project = ProjectSummary(name: 'P', blueprintCount: 1, syncedLabel: 'now', memberInitials: ['T']);
  const vault = StorageUsage(1, 10);

  setUpAll(() => registerFallbackValue(none));

  setUp(() {
    getCurrentUser = MockGetCurrentUser();
    getFeaturedProject = MockGetFeaturedProject();
    getRecentFiles = MockGetRecentFiles();
    getVaultUsage = MockGetVaultUsage();

    when(() => getFeaturedProject(any())).thenAnswer((_) async => const Right(project));
    when(() => getRecentFiles(any())).thenAnswer((_) async => const Right(<DocumentFile>[]));
    when(() => getVaultUsage(any())).thenAnswer((_) async => const Right(vault));
  });

  HomeCubit build() => HomeCubit(
        getCurrentUser: getCurrentUser,
        getFeaturedProject: getFeaturedProject,
        getRecentFiles: getRecentFiles,
        getVaultUsage: getVaultUsage,
      );

  blocTest<HomeCubit, HomeState>(
    'emits success with all dashboard data',
    setUp: () => when(() => getCurrentUser(any())).thenAnswer((_) async => const Right(user)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      HomeState(status: HomeStatus.loading),
      HomeState(
        status: HomeStatus.success,
        user: user,
        featuredProject: project,
        recentFiles: [],
        vaultUsage: vault,
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits failure when any use case fails',
    setUp: () =>
        when(() => getCurrentUser(any())).thenAnswer((_) async => const Left(CacheFailure('No user'))),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => const [
      HomeState(status: HomeStatus.loading),
      HomeState(status: HomeStatus.failure, errorMessage: 'No user'),
    ],
  );
}
