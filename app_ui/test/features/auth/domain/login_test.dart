import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/auth/domain/repositories/auth_repository.dart';
import 'package:fekra_house/features/auth/domain/use_cases/login.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late Login login;

  const params = LoginParams(countryCode: '+966', phone: '501234567', password: 'secret123');
  const user = User(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 501234567', organization: 'X');

  setUp(() {
    repository = MockAuthRepository();
    login = Login(repository);
  });

  test('forwards credentials to the repository and returns the user', () async {
    when(() => repository.login(countryCode: '+966', phone: '501234567', password: 'secret123'))
        .thenAnswer((_) async => const Right(user));

    expect(await login(params), const Right<Failure, User>(user));
  });

  test('returns the failure from the repository', () async {
    when(() => repository.login(countryCode: '+966', phone: '501234567', password: 'secret123'))
        .thenAnswer((_) async => const Left(ServerFailure('Wrong password')));

    expect(await login(params), const Left<Failure, User>(ServerFailure('Wrong password')));
  });
}
