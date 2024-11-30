abstract class CurrencyEvent {}

class LoadCurrencyListEvent extends CurrencyEvent {}

class ConvertCurrencyEvent extends CurrencyEvent {
  final double amount;
  final String fromCurrency;
  final String toCurrency;

  ConvertCurrencyEvent({
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
  });
}
