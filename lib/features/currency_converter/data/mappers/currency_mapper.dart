import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';

class CurrencyMapper {
  static List<Currency> toEntity(CurrencyModel model) {
    return model.data.entries
        .map((entry) => Currency(
              currencyCode: entry.key,
              currencyRate: entry.value,
            ))
        .toList();
  }

  static CurrencyModel toModel(List<Currency> entities) {
    final Map<String, double> data = {
      for (var entity in entities) entity.currencyCode: entity.currencyRate
    };

    return CurrencyModel(data: data);
  }
}
