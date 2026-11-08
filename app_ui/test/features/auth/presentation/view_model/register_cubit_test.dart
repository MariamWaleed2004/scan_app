import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/use_cases/register_user.dart';
import 'package:fekra_house/features/auth/presentation/view_model/register_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/register_state.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

void main() {
  late MockRegisterUser registerUser;
  const user = User(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 501234567', organization: 'X');

  setUpAll(() => registerFallbackValue(
      const RegisterParams(fullName: '', title: '', countryCode: '', phone: '', password: '')));

  setUp(() => registerUser = MockRegisterUser());

  Future<void> submit(RegisterCubit cubit) => cubit.register(
        fullName: '  Tariq Mansour ',
        title: ' Architect ',
        countryCode: '+966',
        phone: ' 501234567 ',
        password: 'secret123',
      );

  blocTest<RegisterCubit, RegisterState>(
    'emits submitting then success, and trims the text fields',
    setUp: () => when(() => registerUser(any())).thenAnswer((_) async => const Right(user)),
    build: () => RegisterCubit(registerUser),
    act: submit,
    expect: () => const [
      RegisterState(status: RegisterStatus.submitting),
      RegisterState(status: RegisterStatus.success),
    ],
    verify: (_) {
      final params = verify(() => registerUser(captureAny())).captured.single as RegisterParams;
      expect(params.fullName, 'Tariq Mansour');
      expect(params.title, 'Architect');
      expect(params.phone, '501234567');
      expect(params.password, 'secret123');
    },
  );

  blocTest<RegisterCubit, RegisterState>(
    'emits failure with the failure message',
    setUp: () => when(() => registerUser(any())).thenAnswer((_) async => const Left(ServerFailure('Offline'))),
    build: () => RegisterCubit(registerUser),
    act: submit,
    expect: () => const [
      RegisterState(status: RegisterStatus.submitting),
      RegisterState(status: RegisterStatus.failure, errorMessage: 'Offline'),
    ],
  );
}
