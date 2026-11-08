import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/get_current_user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/verify_otp.dart';
import 'package:fekra_house/features/auth/presentation/view_model/otp_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/otp_state.dart';

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockVerifyOtp extends Mock implements VerifyOtp {}

void main() {
  late MockGetCurrentUser getCurrentUser;
  late MockVerifyOtp verifyOtp;
  const user = User(fullName: 'Tariq', title: 't', phone: '+966 50 123 4567', organization: 'o');

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    getCurrentUser = MockGetCurrentUser();
    verifyOtp = MockVerifyOtp();
  });

  OtpCubit build() => OtpCubit(getCurrentUser: getCurrentUser, verifyOtp: verifyOtp);

  blocTest<OtpCubit, OtpState>(
    'loadPhone emits the user phone',
    setUp: () => when(() => getCurrentUser(any())).thenAnswer((_) async => const Right(user)),
    build: build,
    act: (cubit) => cubit.loadPhone(),
    expect: () => const [OtpState(phone: '+966 50 123 4567')],
  );

  blocTest<OtpCubit, OtpState>(
    'verify emits verifying then verified for a valid code',
    setUp: () => when(() => verifyOtp(any())).thenAnswer((_) async => const Right(true)),
    build: build,
    act: (cubit) => cubit.verify('482000'),
    expect: () => const [
      OtpState(status: OtpStatus.verifying),
      OtpState(status: OtpStatus.verified),
    ],
  );

  blocTest<OtpCubit, OtpState>(
    'verify emits failure for a wrong code',
    setUp: () => when(() => verifyOtp(any())).thenAnswer((_) async => const Right(false)),
    build: build,
    act: (cubit) => cubit.verify('000000'),
    expect: () => const [
      OtpState(status: OtpStatus.verifying),
      OtpState(status: OtpStatus.failure, errorMessage: 'Invalid verification code.'),
    ],
  );
}
