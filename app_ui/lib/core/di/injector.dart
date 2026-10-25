import 'package:app_ui/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:app_ui/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_ui/features/auth/domain/usecases/get_current_user.dart';
import 'package:app_ui/features/auth/domain/usecases/register_user.dart';
import 'package:app_ui/features/auth/domain/usecases/verify_otp.dart';
import 'package:app_ui/features/documents/data/datasources/document_mock_datasource.dart';
import 'package:app_ui/features/documents/data/repositories/document_repository_impl.dart';
import 'package:app_ui/features/documents/domain/usecases/document_usecases.dart';
import 'package:app_ui/features/folders/data/datasources/folder_mock_datasource.dart';
import 'package:app_ui/features/folders/data/repositories/folder_repository_impl.dart';
import 'package:app_ui/features/folders/domain/usecases/get_folders.dart';

class Injector {
  Injector._();

  // Repositories
  static final _auth = AuthRepositoryImpl(AuthLocalDataSource());
  static final _docs = DocumentRepositoryImpl(DocumentMockDataSource());
  static final _folders = FolderRepositoryImpl(FolderMockDataSource());

  // Auth
  static final registerUser = RegisterUser(_auth);
  static final verifyOtp = VerifyOtp(_auth);
  static final getCurrentUser = GetCurrentUser(_auth);

  // Documents
  static final getRecentFiles = GetRecentFiles(_docs);
  static final getHistory = GetHistory(_docs);
  static final getFeaturedProject = GetFeaturedProject(_docs);
  static final getVaultUsage = GetVaultUsage(_docs);
  static final getCloudUsage = GetCloudUsage(_docs);

  // Folders
  static final getFolders = GetFolders(_folders);
}
