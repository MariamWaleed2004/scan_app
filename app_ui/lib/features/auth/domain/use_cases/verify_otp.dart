import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp implements UseCase<bool, String> {
  final AuthRepository _repository;
  const VerifyOtp(this._repository);

  @override
  Future<Either<Failure, bool>> call(String code) => _repository.verifyOtp(code);
}
