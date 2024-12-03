import 'dart:convert';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';

class CurrencyHistoricalModel extends CurrencyHistoricalEntity {
  const CurrencyHistoricalModel({
    required super.currencyPair,
    required super.historicalRates,
  });

  factory CurrencyHistoricalModel.fromRawJson(String str) {
    final decoded = json.decode(str) as Map<String, dynamic>;
    if (decoded.isEmpty) {
      throw Exception('Invalid JSON format.');
    }

    final currencyPair = decoded.keys.first; // "USD_BDT"
    final ratesMap = decoded[currencyPair] as Map<String, dynamic>;

    final ratesList = ratesMap.entries.map((entry) {
      return CurrencyRate(
        date: entry.key,
        rate: entry.value.toDouble(),
      );
    }).toList();

    return CurrencyHistoricalModel(
      currencyPair: currencyPair,
      historicalRates: ratesList,
    );
  }

  String toRawJson() {
    final ratesMap = {
      for (var rate in historicalRates) rate.date: rate.rate,
    };
    final data = {currencyPair: ratesMap};
    return json.encode(data);
  }
}
