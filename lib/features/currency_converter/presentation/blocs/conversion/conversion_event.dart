import 'package:equatable/equatable.dart';

abstract class ConversionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConvertCurrencyEvent extends ConversionEvent {
  final double fromCurrency;
  final double toCurrency;
  final double amount;

  ConvertCurrencyEvent({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object?> get props => [fromCurrency, toCurrency, amount];
}
