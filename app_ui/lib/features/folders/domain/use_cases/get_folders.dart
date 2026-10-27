import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/folder.dart';
import '../repositories/folders_repository.dart';

class GetFolders implements UseCase<List<Folder>, NoParams> {
  final FoldersRepository _repository;
  const GetFolders(this._repository);

  @override
  Future<Either<Failure, List<Folder>>> call(NoParams params) => _repository.getFolders();
}
