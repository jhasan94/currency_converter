import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HistoricalDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoricalDataInitialState extends HistoricalDataState {}

class HistoricalDataLoadingState extends HistoricalDataState {}

class HistoricalDataSuccessState extends HistoricalDataState {
  final List<CurrencyRate> historicalData;

  HistoricalDataSuccessState({required this.historicalData});

  @override
  List<Object?> get props => [historicalData];
}

class HistoricalDataErrorState extends HistoricalDataState {
  final String message;

  HistoricalDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
