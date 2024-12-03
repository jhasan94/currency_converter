import 'dart:convert';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';

class CurrencyModel extends Currency {
  const CurrencyModel({
    required super.id,
    required super.countryName,
    required super.currencyId,
    required super.currencyName,
    required super.currencySymbol,
  });

  static List<CurrencyModel> fromRawJson(String str) {
    final decoded = json.decode(str) as Map<String, dynamic>;
    final results = decoded['results'] as Map<String, dynamic>;

    return results.entries.map((entry) {
      return CurrencyModel.fromJson(entry.value); // entry.value contains the currency data
    }).toList();
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      name: json['name'],
      currencyId: json['currencyId'],
      currencyName: json['currencyName'],
      currencySymbol: json['currencySymbol'] ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': countryName,
      'currencyId': currencyId,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
    };
  }
}
