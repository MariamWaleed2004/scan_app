import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failure_guard.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../../domain/entities/folder.dart';
import '../../domain/repositories/folders_repository.dart';
import '../data_sources/folders_mock_data_source.dart';

class FoldersRepositoryImpl implements FoldersRepository {
  final FoldersMockDataSource _source;
  const FoldersRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<Folder>>> getFolders() =>
      guardFailure(() async => (await _source.getFolders()).map((m) => m.toEntity()).toList());
}
