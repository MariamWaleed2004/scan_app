import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/document_file.dart';
import '../repositories/documents_repository.dart';

class AddDocument implements UseCase<Unit, DocumentFile> {
  final DocumentsRepository _repository;
  const AddDocument(this._repository);

  @override
  Future<Either<Failure, Unit>> call(DocumentFile document) => _repository.addDocument(document);
}
