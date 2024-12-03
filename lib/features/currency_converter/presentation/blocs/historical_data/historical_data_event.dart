import 'package:equatable/equatable.dart';

abstract class LoadHistoricalDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoricalDataEvent extends LoadHistoricalDataEvent {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  HistoricalDataEvent({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object?> get props => [fromCurrency, toCurrency, amount];
}
