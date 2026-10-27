import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final AuthRepository _repository;
  const GetCurrentUser(this._repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) => _repository.getCurrentUser();
}
