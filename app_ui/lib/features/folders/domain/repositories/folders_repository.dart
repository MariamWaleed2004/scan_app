import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../entities/folder.dart';

abstract class FoldersRepository {
  Future<Either<Failure, List<Folder>>> getFolders();
}
