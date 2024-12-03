import 'dart:convert';

import 'package:currency_converter/features/currency_converter/domain/entities/currency_coversion_enitty.dart';

class CurrencyConversionModel extends CurrencyConversionEntity {
  CurrencyConversionModel({required super.conversions});

  factory CurrencyConversionModel.fromRawJson(String str) {
    final decoded = json.decode(str);
    final Map<String, double> conversions = {};

    decoded.forEach((key, value) {
      conversions[key] = value.toDouble();
    });

    return CurrencyConversionModel(conversions: conversions);
  }

  CurrencyConversionEntity toEntity() {
    return CurrencyConversionEntity(conversions: conversions);
  }
}
