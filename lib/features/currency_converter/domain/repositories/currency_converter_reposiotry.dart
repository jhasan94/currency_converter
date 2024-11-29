import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';

abstract class CurrencyConverterRepository {
  const CurrencyConverterRepository();

  FutureResult<List<Currency>> getCurrencyList();
}
