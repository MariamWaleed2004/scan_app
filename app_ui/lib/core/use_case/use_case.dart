import 'package:dartz/dartz.dart';
import 'package:fekra_house/core/errors/failures.dart';

/// Base contract for every use case: success or [Failure], never a thrown error.
abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {
  const NoParams();
}
