import 'package:app_ui/core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp implements UseCase<bool, String> {
  final AuthRepository _repo;
  const VerifyOtp(this._repo);

  @override
  Future<bool> call(String code) => _repo.verifyOtp(code);
}
