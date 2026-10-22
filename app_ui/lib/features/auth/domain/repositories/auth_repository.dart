import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password,
  });
  Future<bool> verifyOtp(String code);
  Future<UserEntity> getCurrentUser();
}
