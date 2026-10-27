import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/document_file.dart';
import '../repositories/documents_repository.dart';

class GetRecentFiles implements UseCase<List<DocumentFile>, NoParams> {
  final DocumentsRepository _repository;
  const GetRecentFiles(this._repository);

  @override
  Future<Either<Failure, List<DocumentFile>>> call(NoParams params) => _repository.getRecentFiles();
}
