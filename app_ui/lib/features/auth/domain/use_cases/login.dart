import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String countryCode, phone, password;
  const LoginParams({required this.countryCode, required this.phone, required this.password});
}

class Login implements UseCase<User, LoginParams> {
  final AuthRepository _repository;
  const Login(this._repository);

  @override
  Future<Either<Failure, User>> call(LoginParams p) =>
      _repository.login(countryCode: p.countryCode, phone: p.phone, password: p.password);
}
