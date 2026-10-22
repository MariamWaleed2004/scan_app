import 'package:app_ui/core/usecase/usecase.dart';
import '../entities/user_entity.dart';
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

class RegisterUser implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository _repo;
  const RegisterUser(this._repo);

  @override
  Future<UserEntity> call(RegisterParams p) => _repo.register(
        fullName: p.fullName,
        title: p.title,
        countryCode: p.countryCode,
        phone: p.phone,
        password: p.password,
      );
}
