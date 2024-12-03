import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/use_case/use_case.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';

class GetCurrencyList extends UseCaseWithoutParams<List<Currency>> {
  const GetCurrencyList(this._repository);
  final CurrencyConverterRepository _repository;
  @override
  FutureResult<List<Currency>> call() async =>
      _repository.getCurrencyList();
}
