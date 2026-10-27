import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/login.dart';
import 'package:fekra_house/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/login_state.dart';

class MockLogin extends Mock implements Login {}

void main() {
  late MockLogin login;
  const user = User(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 501234567', organization: 'X');

  setUpAll(() => registerFallbackValue(const LoginParams(countryCode: '', phone: '', password: '')));
  setUp(() => login = MockLogin());

  Future<void> submit(LoginCubit cubit) =>
      cubit.login(countryCode: '+966', phone: ' 501234567 ', password: 'secret123');

  blocTest<LoginCubit, LoginState>(
    'emits submitting then success, and trims the phone',
    setUp: () => when(() => login(any())).thenAnswer((_) async => const Right(user)),
    build: () => LoginCubit(login),
    act: submit,
    expect: () => const [
      LoginState(status: LoginStatus.submitting),
      LoginState(status: LoginStatus.success),
    ],
    verify: (_) {
      final params = verify(() => login(captureAny())).captured.single as LoginParams;
      expect(params.phone, '501234567');
      expect(params.password, 'secret123');
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits failure with the failure message',
    setUp: () => when(() => login(any())).thenAnswer((_) async => const Left(ServerFailure('Wrong password'))),
    build: () => LoginCubit(login),
    act: submit,
    expect: () => const [
      LoginState(status: LoginStatus.submitting),
      LoginState(status: LoginStatus.failure, errorMessage: 'Wrong password'),
    ],
  );
}
