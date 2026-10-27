import 'package:dartz/dartz.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Runs a data-source call at the repository boundary and converts
/// exceptions into [Failure]s, so repositories always return `Either`.
Future<Either<Failure, T>> guardFailure<T>(Future<T> Function() run) async {
  try {
    return Right(await run());
  } on ServerException catch (e) {
    return Left(e.message == null ? const ServerFailure() : ServerFailure(e.message!));
  } on CacheException catch (e) {
    return Left(e.message == null ? const CacheFailure() : CacheFailure(e.message!));
  } catch (_) {
    return const Left<Failure, Never>(UnexpectedFailure());
  }
}
