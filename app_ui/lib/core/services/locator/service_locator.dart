import 'package:get_it/get_it.dart';
import 'package:fekra_house/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:fekra_house/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fekra_house/features/auth/domain/repositories/auth_repository.dart';
import 'package:fekra_house/features/auth/domain/use_cases/get_current_user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/login.dart';
import 'package:fekra_house/features/auth/domain/use_cases/register_user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/verify_otp.dart';
import 'package:fekra_house/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/otp_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/register_cubit.dart';
import 'package:fekra_house/features/documents/data/data_sources/documents_mock_data_source.dart';
import 'package:fekra_house/features/documents/data/repositories/documents_repository_impl.dart';
import 'package:fekra_house/features/documents/domain/repositories/documents_repository.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_cloud_usage.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_featured_project.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_history.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_recent_files.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_vault_usage.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_cubit.dart';
import 'package:fekra_house/features/folders/data/data_sources/folders_mock_data_source.dart';
import 'package:fekra_house/features/folders/data/repositories/folders_repository_impl.dart';
import 'package:fekra_house/features/folders/domain/repositories/folders_repository.dart';
import 'package:fekra_house/features/folders/domain/use_cases/get_folders.dart';
import 'package:fekra_house/features/folders/presentation/view_model/folders_cubit.dart';
import 'package:fekra_house/features/home/presentation/view_model/home_cubit.dart';
import 'package:fekra_house/features/profile/presentation/view_model/profile_cubit.dart';

final sl = GetIt.instance;

/// Registers every dependency, in the order that shows how they relate:
/// services → data sources → repositories → use cases → cubits.
void setupServiceLocator() {
  // 1. Shared services
  //    None yet. Add DioClient, TokenStorage, SessionService, ... here when needed.

  // 2. Data sources (singletons: the in-memory mocks keep their state)
  sl
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource())
    ..registerLazySingleton<DocumentsMockDataSource>(() => DocumentsMockDataSource())
    ..registerLazySingleton<FoldersMockDataSource>(() => FoldersMockDataSource());

  // 3. Repositories: contract → implementation
  sl
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<DocumentsRepository>(() => DocumentsRepositoryImpl(sl()))
    ..registerLazySingleton<FoldersRepository>(() => FoldersRepositoryImpl(sl()));

  // 4. Use cases
  sl
    // auth
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => RegisterUser(sl()))
    ..registerLazySingleton(() => VerifyOtp(sl()))
    ..registerLazySingleton(() => GetCurrentUser(sl()))
    // documents
    ..registerLazySingleton(() => GetRecentFiles(sl()))
    ..registerLazySingleton(() => GetHistory(sl()))
    ..registerLazySingleton(() => GetFeaturedProject(sl()))
    ..registerLazySingleton(() => GetVaultUsage(sl()))
    ..registerLazySingleton(() => GetCloudUsage(sl()))
    // folders
    ..registerLazySingleton(() => GetFolders(sl()));

  // 5. Cubits (factories: a new one per screen, closed by its BlocProvider)
  sl
    ..registerFactory(() => LoginCubit(sl()))
    ..registerFactory(() => RegisterCubit(sl()))
    ..registerFactory(() => OtpCubit(getCurrentUser: sl(), verifyOtp: sl()))
    ..registerFactory(() => HomeCubit(
          getCurrentUser: sl(),
          getFeaturedProject: sl(),
          getRecentFiles: sl(),
          getVaultUsage: sl(),
        ))
    ..registerFactory(() => FoldersCubit(getFolders: sl(), getCloudUsage: sl()))
    ..registerFactory(() => HistoryCubit(sl()))
    ..registerFactory(() => ProfileCubit(sl()));
}
