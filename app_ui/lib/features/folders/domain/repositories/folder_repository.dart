import '../entities/folder_entity.dart';

abstract class FolderRepository {
  Future<List<FolderEntity>> getFolders();
}
