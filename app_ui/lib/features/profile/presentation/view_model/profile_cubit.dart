import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/auth/domain/use_cases/get_current_user.dart';
import 'profile_state.dart';

/// Reuses the auth domain's GetCurrentUser instead of duplicating a User entity.
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUser _getCurrentUser;
  ProfileCubit(this._getCurrentUser) : super(const ProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _getCurrentUser(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, errorMessage: failure.message)),
      (user) => emit(state.copyWith(status: ProfileStatus.success, user: user)),
    );
  }
}
