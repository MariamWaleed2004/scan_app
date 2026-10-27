import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/login.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _login;
  LoginCubit(this._login) : super(const LoginState());

  Future<void> login({required String countryCode, required String phone, required String password}) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));

    final result = await _login(LoginParams(countryCode: countryCode, phone: phone.trim(), password: password));

    result.fold(
      (failure) => emit(state.copyWith(status: LoginStatus.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }
}
