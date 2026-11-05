import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/repositories/auth_repository.dart';
import 'package:fekra_house/features/auth/domain/use_cases/register_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late RegisterUser registerUser;

  const params = RegisterParams(
    fullName: 'Tariq Mansour',
    title: 'Architect',
    countryCode: '+966',
    phone: '501234567',
    password: 'secret',
  );
  const user = User(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 501234567', organization: 'X');

  setUp(() {
    repository = MockAuthRepository();
    registerUser = RegisterUser(repository);
  });

  Future<Either<Failure, User>> callRepo() => repository.register(
        fullName: any(named: 'fullName'),
        title: any(named: 'title'),
        countryCode: any(named: 'countryCode'),
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      );

  test('forwards params to the repository and returns the user', () async {
    when(callRepo).thenAnswer((_) async => const Right(user));

    final result = await registerUser(params);

    expect(result, const Right<Failure, User>(user));
    verify(() => repository.register(
          fullName: 'Tariq Mansour',
          title: 'Architect',
          countryCode: '+966',
          phone: '501234567',
          password: 'secret',
        )).called(1);
  });

  test('returns the failure from the repository', () async {
    when(callRepo).thenAnswer((_) async => const Left(ServerFailure()));

    final result = await registerUser(params);

    expect(result, const Left<Failure, User>(ServerFailure()));
  });
}
