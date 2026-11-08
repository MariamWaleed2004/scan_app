import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/project_summary.dart';
import '../repositories/documents_repository.dart';

class GetFeaturedProject implements UseCase<ProjectSummary, NoParams> {
  final DocumentsRepository _repository;
  const GetFeaturedProject(this._repository);

  @override
  Future<Either<Failure, ProjectSummary>> call(NoParams params) => _repository.getFeaturedProject();
}
