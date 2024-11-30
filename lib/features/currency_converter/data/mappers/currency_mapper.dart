import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';

class CurrencyMapper {
  static List<Currency> toEntity(CurrencyModel model) {
    return model.data.entries
        .map((entry) => Currency(
            currencyCode: entry.key,
            currencyRate: entry.value,
            currencyFlag:
                'https://flagcdn.com/16x12/${entry.key.substring(0, 2).toLowerCase()}.png'))
        .toList();
  }
}
