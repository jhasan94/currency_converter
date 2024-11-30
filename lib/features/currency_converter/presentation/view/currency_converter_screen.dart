import 'currency_converter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/conversion/cnversion_bloc.dart';
import 'package:currency_converter/core/service_locator/service_locator.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/app_bar.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/currency_bloc/currency_bloc.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/currency_bloc/currency_bloc_event.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/currency_bloc/currency_bloc_state.dart';

class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CurrencyBloc>()..add(LoadCurrencyListEvent()),
      child: BlocProvider<ConversionBloc>(
        create: (context) => ConversionBloc(sl.get<ConvertCurrency>()),
        child: Scaffold(
          backgroundColor: const Color(0xFFE8F5E9),
          appBar: customAppBar(title: 'Currency Converter'),
          body: const CurrencyConverterWidget(),
        ),
      ),
    );
  }
}

class CurrencyConverterWidget extends StatelessWidget {
  const CurrencyConverterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrencyLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CurrencyConverterForm(currencies: state.currencies),
              ],
            ),
          );
        } else if (state is CurrencyErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
