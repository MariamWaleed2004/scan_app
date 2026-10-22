import 'package:app_ui/core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository _repo;
  const GetCurrentUser(this._repo);

  @override
  Future<UserEntity> call(NoParams params) => _repo.getCurrentUser();
}
