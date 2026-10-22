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
