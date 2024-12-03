import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_coversion_enitty.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';

abstract class CurrencyConverterRepository {
  const CurrencyConverterRepository();

  FutureResult<List<Currency>> getCurrencyList();
  FutureResult<CurrencyConversionEntity> getCurrencyConvertResult(Map<String, dynamic> params);
  FutureResult<List<CurrencyRate>> getHistoricalData(Map<String, dynamic> params);
}
