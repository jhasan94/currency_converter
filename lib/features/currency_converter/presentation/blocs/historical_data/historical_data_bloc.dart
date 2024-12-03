import 'package:currency_converter/features/currency_converter/domain/use_cases/get_historical_data.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_event.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricalDataBloc
    extends Bloc<LoadHistoricalDataEvent, HistoricalDataState> {
  final GetHistoricalData getHistoricalData;

  HistoricalDataBloc(this.getHistoricalData)
      : super(HistoricalDataInitialState()) {
    on<HistoricalDataEvent>((event, emit) async {
      emit(HistoricalDataLoadingState());
      final result = await getHistoricalData(
        HistoricalDataParams(
            fromCurrency: event.fromCurrency,
            toCurrency: event.toCurrency,
            amount: event.amount),
      );
      result.fold(
        (failure) => emit(HistoricalDataErrorState(message: failure.message)),
        (data) => emit(HistoricalDataSuccessState(historicalData: data)),
      );
    });
  }
}
