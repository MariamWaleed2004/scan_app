import 'package:get_it/get_it.dart';
import 'package:fekra_house/core/services/files/file_opener.dart';
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
import 'package:fekra_house/features/documents/data/data_sources/documents_local_data_source.dart';
import 'package:fekra_house/features/documents/data/data_sources/documents_mock_data_source.dart';
import 'package:fekra_house/features/documents/data/repositories/documents_repository_impl.dart';
import 'package:fekra_house/features/documents/domain/repositories/documents_repository.dart';
import 'package:fekra_house/features/documents/domain/use_cases/add_document.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_cloud_usage.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_featured_project.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_history.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_recent_files.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_vault_usage.dart';
import 'package:fekra_house/features/documents/domain/use_cases/watch_document_changes.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_cubit.dart';
import 'package:fekra_house/features/folders/data/data_sources/folders_mock_data_source.dart';
import 'package:fekra_house/features/folders/data/repositories/folders_repository_impl.dart';
import 'package:fekra_house/features/folders/domain/repositories/folders_repository.dart';
import 'package:fekra_house/features/folders/domain/use_cases/get_folders.dart';
import 'package:fekra_house/features/folders/presentation/view_model/folders_cubit.dart';
import 'package:fekra_house/features/home/presentation/view_model/home_cubit.dart';
import 'package:fekra_house/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:fekra_house/features/scan/data/data_sources/scan_pdf_local_data_source.dart';
import 'package:fekra_house/features/scan/data/repositories/scan_repository_impl.dart';
import 'package:fekra_house/features/scan/domain/repositories/scan_repository.dart';
import 'package:fekra_house/features/scan/domain/use_cases/save_scan_as_pdf.dart';
import 'package:fekra_house/features/scan/presentation/view_model/scan_cubit.dart';

final sl = GetIt.instance;

/// Registers every dependency, in the order that shows how they relate:
/// services → data sources → repositories → use cases → cubits.
void setupServiceLocator() {
  // 1. Shared services (add DioClient, TokenStorage, SessionService, ... here when needed)
  sl.registerLazySingleton<FileOpener>(() => OpenFilexFileOpener());

  // 2. Data sources (singletons: the in-memory mocks keep their state)
  sl
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource())
    ..registerLazySingleton<DocumentsMockDataSource>(() => DocumentsMockDataSource())
    ..registerLazySingleton<DocumentsLocalDataSource>(() => DocumentsLocalDataSource())
    ..registerLazySingleton<FoldersMockDataSource>(() => FoldersMockDataSource())
    ..registerLazySingleton<ScanPdfLocalDataSource>(() => ScanPdfLocalDataSource());

  // 3. Repositories: contract → implementation
  sl
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<DocumentsRepository>(() => DocumentsRepositoryImpl(mock: sl(), local: sl()))
    ..registerLazySingleton<FoldersRepository>(() => FoldersRepositoryImpl(sl()))
    ..registerLazySingleton<ScanRepository>(() => ScanRepositoryImpl(sl()));

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
    ..registerLazySingleton(() => AddDocument(sl()))
    ..registerLazySingleton(() => WatchDocumentChanges(sl()))
    // folders
    ..registerLazySingleton(() => GetFolders(sl()))
    // scan
    ..registerLazySingleton(() => SaveScanAsPdf(sl(), sl()));

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
    ..registerFactory(() => HistoryCubit(getHistory: sl(), watchDocumentChanges: sl(), fileOpener: sl()))
    ..registerFactory(() => ProfileCubit(sl()))
    ..registerFactory(() => ScanCubit(saveScanAsPdf: sl(), fileOpener: sl()));
}
