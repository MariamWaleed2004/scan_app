import '../../domain/entities/folder_entity.dart';
import '../../domain/repositories/folder_repository.dart';
import '../datasources/folder_mock_datasource.dart';

class FolderRepositoryImpl implements FolderRepository {
  final FolderMockDataSource _ds;
  const FolderRepositoryImpl(this._ds);

  @override
  Future<List<FolderEntity>> getFolders() => _ds.folders();
}
