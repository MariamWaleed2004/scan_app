import '../models/user_model.dart';

/// In-memory mock. Replace with a remote (REST / Firebase) data source later.
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
  }) async {
    _user = UserModel(
      fullName: fullName.isEmpty ? _user.fullName : fullName,
      title: title.isEmpty ? _user.title : title,
      phone: phone.isEmpty ? _user.phone : '$countryCode $phone',
      organization: _user.organization,
    );
    return _user;
  }

  Future<bool> verifyOtp(String code) async => true; // mock: always succeeds

  Future<UserModel> currentUser() async => _user;
}
