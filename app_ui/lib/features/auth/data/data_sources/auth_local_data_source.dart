import '../models/user_model.dart';

/// In-memory mock. Add an `AuthRemoteDataSource` (Dio / Firebase) when the API is ready;
/// only the repository implementation needs to change.
class AuthLocalDataSource {
  UserModel _user = const UserModel(
    fullName: 'Tariq Mansour',
    title: 'Senior Project Architect',
    phone: '+966 50 123 4567',
    organization: 'Dar Al-Handasah Studio',
  );

  Future<UserModel> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password, // ignored by the mock
  }) async {
    _user = UserModel(
      fullName: fullName.isEmpty ? _user.fullName : fullName,
      title: title.isEmpty ? _user.title : title,
      phone: phone.isEmpty ? _user.phone : '$countryCode $phone',
      organization: _user.organization,
    );
    return _user;
  }

  /// Mock: any well-formed phone/password logs in as the saved user.
  Future<UserModel> login({
    required String countryCode,
    required String phone,
    required String password, // ignored by the mock
  }) async {
    _user = UserModel(
      fullName: _user.fullName,
      title: _user.title,
      phone: '$countryCode $phone',
      organization: _user.organization,
    );
    return _user;
  }

  Future<bool> verifyOtp(String code) async => true; // mock: always succeeds

  Future<UserModel> getCurrentUser() async => _user;
}
