import 'package:currency_converter/core/utils/typedef.dart';

abstract class UseCaseWithParams<Type, Params>{
  const UseCaseWithParams();
  FutureResult<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type>{
  const UseCaseWithoutParams();
  FutureResult<Type> call();
}