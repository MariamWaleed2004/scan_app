import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _ds;
  const AuthRepositoryImpl(this._ds);

  @override
  Future<UserEntity> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password,
  }) =>
      _ds.register(fullName: fullName, title: title, countryCode: countryCode, phone: phone);

  @override
  Future<bool> verifyOtp(String code) => _ds.verifyOtp(code);

  @override
  Future<UserEntity> getCurrentUser() => _ds.currentUser();
}
