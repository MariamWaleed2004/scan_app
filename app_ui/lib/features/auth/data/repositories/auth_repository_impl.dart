import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failure_guard.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _local;
  const AuthRepositoryImpl(this._local);

  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password,
  }) =>
      guardFailure(() async => (await _local.register(
            fullName: fullName,
            title: title,
            countryCode: countryCode,
            phone: phone,
            password: password,
          ))
              .toEntity());

  @override
  Future<Either<Failure, User>> login({
    required String countryCode,
    required String phone,
    required String password,
  }) =>
      guardFailure(() async =>
          (await _local.login(countryCode: countryCode, phone: phone, password: password)).toEntity());

  @override
  Future<Either<Failure, bool>> verifyOtp(String code) => guardFailure(() => _local.verifyOtp(code));

  @override
  Future<Either<Failure, User>> getCurrentUser() =>
      guardFailure(() async => (await _local.getCurrentUser()).toEntity());
}
