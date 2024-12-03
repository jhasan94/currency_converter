import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/conversion/conversion_event.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/conversion/conversion_state.dart';

class ConversionBloc extends Bloc<ConversionEvent, ConversionState> {
  final ConvertCurrency convertCurrency;

  ConversionBloc(this.convertCurrency) : super(ConversionInitial()) {
    on<ConvertCurrencyEvent>((event, emit) async {
      emit(ConversionLoading());
      final result = await convertCurrency(
        ConvertCurrencyParams(
            fromCurrency: event.fromCurrency,
            toCurrency: event.toCurrency,
            amount: event.amount),
      );
      result.fold(
        (failure) => emit(ConversionError(message: failure.message)),
        (convertedAmount) => emit(ConversionSuccess(convertedAmount: convertedAmount)),
      );
    });
  }
}
