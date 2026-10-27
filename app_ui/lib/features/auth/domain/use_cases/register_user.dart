import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String fullName, title, countryCode, phone, password;
  const RegisterParams({
    required this.fullName,
    required this.title,
    required this.countryCode,
    required this.phone,
    required this.password,
  });
}

class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthRepository _repository;
  const RegisterUser(this._repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams p) => _repository.register(
        fullName: p.fullName,
        title: p.title,
        countryCode: p.countryCode,
        phone: p.phone,
        password: p.password,
      );
}
