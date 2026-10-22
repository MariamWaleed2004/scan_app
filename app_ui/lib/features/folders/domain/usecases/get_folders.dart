import 'package:app_ui/core/usecase/usecase.dart';
import '../entities/folder_entity.dart';
import '../repositories/folder_repository.dart';

class GetFolders implements UseCase<List<FolderEntity>, NoParams> {
  final FolderRepository _r;
  const GetFolders(this._r);
  @override
  Future<List<FolderEntity>> call(NoParams p) => _r.getFolders();
}
