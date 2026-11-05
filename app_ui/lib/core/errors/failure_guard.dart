import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Runs a data-source call at the repository boundary and converts
/// exceptions into [Failure]s, so repositories always return `Either`.
/// Every error is also logged (visible in the IDE's Debug Console).
Future<Either<Failure, T>> guardFailure<T>(Future<T> Function() run) async {
  try {
    return Right(await run());
  } on ServerException catch (e, st) {
    _log(e, st);
    return Left(e.message == null ? const ServerFailure() : ServerFailure(e.message!));
  } on CacheException catch (e, st) {
    _log(e, st);
    return Left(e.message == null ? const CacheFailure() : CacheFailure(e.message!));
  } catch (e, st) {
    _log(e, st);
    return const Left<Failure, Never>(UnexpectedFailure());
  }
}

void _log(Object error, StackTrace stackTrace) =>
    developer.log('Repository call failed', name: 'fekra_house', error: error, stackTrace: stackTrace);
