import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../../domain/use_cases/get_current_user.dart';
import '../../domain/use_cases/verify_otp.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final GetCurrentUser _getCurrentUser;
  final VerifyOtp _verifyOtp;

  OtpCubit({required GetCurrentUser getCurrentUser, required VerifyOtp verifyOtp})
      : _getCurrentUser = getCurrentUser,
        _verifyOtp = verifyOtp,
        super(const OtpState());

  Future<void> loadPhone() async {
    final result = await _getCurrentUser(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (user) => emit(state.copyWith(phone: user.phone)),
    );
  }

  Future<void> verify(String code) async {
    if (state.isVerifying) return;
    emit(state.copyWith(status: OtpStatus.verifying));

    final result = await _verifyOtp(code);
    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (ok) => emit(ok
          ? state.copyWith(status: OtpStatus.verified)
          : state.copyWith(status: OtpStatus.failure, errorMessage: 'Invalid verification code.')),
    );
  }
}
