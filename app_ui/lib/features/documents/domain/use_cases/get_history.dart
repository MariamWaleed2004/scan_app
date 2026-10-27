import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/history_group.dart';
import '../repositories/documents_repository.dart';

class GetHistory implements UseCase<List<HistoryGroup>, NoParams> {
  final DocumentsRepository _repository;
  const GetHistory(this._repository);

  @override
  Future<Either<Failure, List<HistoryGroup>>> call(NoParams params) => _repository.getHistory();
}
