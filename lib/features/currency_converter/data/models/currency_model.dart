import 'dart:convert';

class CurrencyModel {
  final Map<String, double> data;

  CurrencyModel({
    required this.data,
  });

  factory CurrencyModel.fromRawJson(String str) =>
      CurrencyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        data: Map.from(json["conversion_rates"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "conversion_rates":
            Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
