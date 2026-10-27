import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/exceptions.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:fekra_house/features/auth/data/models/user_model.dart';
import 'package:fekra_house/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthLocalDataSource source;
  late AuthRepositoryImpl repository;

  const model = UserModel(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 50', organization: 'Studio');
  const entity = User(fullName: 'Tariq Mansour', title: 'Architect', phone: '+966 50', organization: 'Studio');

  setUp(() {
    source = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(source);
  });

  test('returns the mapped entity on success', () async {
    when(() => source.getCurrentUser()).thenAnswer((_) async => model);

    expect(await repository.getCurrentUser(), const Right<Failure, User>(entity));
  });

  test('converts CacheException into CacheFailure', () async {
    when(() => source.getCurrentUser()).thenThrow(const CacheException('No saved user'));

    expect(await repository.getCurrentUser(), const Left<Failure, User>(CacheFailure('No saved user')));
  });

  test('converts unknown errors into UnexpectedFailure', () async {
    when(() => source.verifyOtp('123')).thenThrow(StateError('boom'));

    expect(await repository.verifyOtp('123'), const Left<Failure, bool>(UnexpectedFailure()));
  });
}
