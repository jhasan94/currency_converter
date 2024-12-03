import 'package:currency_converter/core/app_secret.dart';

enum RequestType { get, post }

class ApiEndPoints {
  //static String baseUrl = 'https://v6.exchangerate-api.com';
  //static String currency = '/v6/6bf723403158653eeed70229/latest/usd';
  static String baseUrl = 'https://free.currconv.com';
  static String currencies = "/api/v8/countries?apiKey=${AppSecret.apiKey}";
  static String currencyConversion = "/api/v8/convert";
}
