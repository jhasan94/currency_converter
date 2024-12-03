import 'currency_bloc_event.dart';
import 'currency_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currency_list.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrencyList getCurrencyList;

  CurrencyBloc({
    required this.getCurrencyList,
  }) : super(CurrencyInitialState()) {
    on<LoadCurrencyListEvent>(_onLoadCurrencyList);
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
}
