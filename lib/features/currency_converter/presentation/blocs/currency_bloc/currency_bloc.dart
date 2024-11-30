import 'currency_bloc_event.dart';
import 'currency_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currency_list.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrencyList getCurrencyList;
  final ConvertCurrency convertCurrency;

  CurrencyBloc({
    required this.getCurrencyList,
    required this.convertCurrency,
  }) : super(CurrencyInitialState()) {
    on<LoadCurrencyListEvent>(_onLoadCurrencyList);
    on<ConvertCurrencyEvent>(_onConvertCurrency);
  }

  Future<void> _onLoadCurrencyList(
    LoadCurrencyListEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoadingState());
    final result = await getCurrencyList();
    result.fold(
      (failure) => emit(CurrencyErrorState(message: failure.message)),
      (currencies) => emit(CurrencyLoadedState(currencies: currencies)),
    );
  }

  Future<void> _onConvertCurrency(
    ConvertCurrencyEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoadingState());
    final result = await convertCurrency(
      ConvertCurrencyParams(
          fromRate: double.tryParse(event.fromCurrency) ?? 0,
          toRate: double.tryParse(event.fromCurrency) ?? 0,
          amount: event.amount),
    );
    result.fold(
      (failure) => emit(CurrencyErrorState(message: failure.message)),
      (convertedAmount) =>
          emit(CurrencyConvertedState(convertedAmount: convertedAmount)),
    );
  }
}
