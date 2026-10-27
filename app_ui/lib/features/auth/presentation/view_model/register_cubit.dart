import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/register_user.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser _registerUser;
  RegisterCubit(this._registerUser) : super(const RegisterState());

  Future<void> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(status: RegisterStatus.submitting));

    final result = await _registerUser(RegisterParams(
      fullName: fullName.trim(),
      title: title.trim(),
      countryCode: countryCode,
      phone: phone.trim(),
      password: password,
    ));

    result.fold(
      (failure) => emit(state.copyWith(status: RegisterStatus.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: RegisterStatus.success)),
    );
  }
}
