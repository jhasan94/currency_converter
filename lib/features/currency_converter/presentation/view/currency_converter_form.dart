import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/conversion/cnversion_bloc.dart';
import '../blocs/conversion/conversion_state.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/currency_drop_down.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/amount_input_field.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/conversion/conversion_event.dart';

class CurrencyConverterForm extends StatefulWidget {
  final List<Currency> currencies;

  const CurrencyConverterForm({super.key, required this.currencies});

  @override
  CurrencyConverterFormState createState() => CurrencyConverterFormState();
}

class CurrencyConverterFormState extends State<CurrencyConverterForm> {
  double? fromCurrency;
  double? toCurrency;
  double? amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'From',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        CurrencyDropdown(
          currencies: widget.currencies,
          onChanged: (value) =>
              setState(() => fromCurrency = value?.currencyRate),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'To',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        CurrencyDropdown(
          currencies: widget.currencies,
          onChanged: (value) =>
              setState(() => toCurrency = value?.currencyRate),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Amount',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        AmountInputField(
          onChanged: (value) => setState(() => amount = double.tryParse(value)),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                if (fromCurrency != null &&
                    toCurrency != null &&
                    amount != null) {
                  context.read<ConversionBloc>().add(ConvertCurrencyEvent(
                        fromCurrency: fromCurrency!,
                        toCurrency: toCurrency!,
                        amount: amount!,
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Convert',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        BlocBuilder<ConversionBloc, ConversionState>(
          builder: (context, state) {
            if (state is ConversionLoading) {
              return const CircularProgressIndicator();
            } else if (state is ConversionSuccess) {
              return Center(
                  child: Text(
                'Converted Amount: ${state.convertedAmount.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ));
            } else if (state is ConversionError) {
              return Text('Error: ${state.message}');
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
