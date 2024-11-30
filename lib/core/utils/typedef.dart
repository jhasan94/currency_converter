import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:dartz/dartz.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef VoidResult = FutureResult<void>;