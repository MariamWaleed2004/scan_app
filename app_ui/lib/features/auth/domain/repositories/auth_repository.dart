import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register({
    required String fullName,
    required String title,
    required String countryCode,
    required String phone,
    required String password,
  });

  Future<Either<Failure, User>> login({
    required String countryCode,
    required String phone,
    required String password,
  });

  Future<Either<Failure, bool>> verifyOtp(String code);

  Future<Either<Failure, User>> getCurrentUser();
}
