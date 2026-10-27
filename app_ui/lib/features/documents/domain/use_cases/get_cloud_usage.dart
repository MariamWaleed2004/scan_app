import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/storage_usage.dart';
import '../repositories/documents_repository.dart';

class GetCloudUsage implements UseCase<StorageUsage, NoParams> {
  final DocumentsRepository _repository;
  const GetCloudUsage(this._repository);

  @override
  Future<Either<Failure, StorageUsage>> call(NoParams params) => _repository.getCloudUsage();
}
