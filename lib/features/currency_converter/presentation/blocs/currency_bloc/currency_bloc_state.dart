import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';

abstract class CurrencyState {}

class CurrencyInitialState extends CurrencyState {}

class CurrencyLoadingState extends CurrencyState {}

class CurrencyLoadedState extends CurrencyState {
  final List<Currency> currencies;
  CurrencyLoadedState({required this.currencies});
}

class CurrencyErrorState extends CurrencyState {
  final String message;
  CurrencyErrorState({required this.message});
}
