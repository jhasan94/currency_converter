import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_bloc.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_event.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_state.dart';
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
  String? fromCurrency;
  String? toCurrency;
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
              setState(() => fromCurrency = value?.currencyId),
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
          onChanged: (value) => setState(() => toCurrency = value?.currencyId),
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
                FocusScope.of(context).requestFocus(FocusNode());
                if (fromCurrency != null &&
                    toCurrency != null &&
                    amount != null) {
                  context.read<ConversionBloc>().add(ConvertCurrencyEvent(
                        fromCurrency: fromCurrency!,
                        toCurrency: toCurrency!,
                        amount: amount!,
                      ));
                  context.read<HistoricalDataBloc>().add(HistoricalDataEvent(
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
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        BlocBuilder<ConversionBloc, ConversionState>(
          builder: (context, state) {
            if (state is ConversionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ConversionSuccess) {
              return Center(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.teal[50],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Converted Amount",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.convertedAmount,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ConversionError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocBuilder<HistoricalDataBloc, HistoricalDataState>(
          builder: (context, state) {
            if (state is HistoricalDataSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Historical Data (Last 7 Days)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Ensures smooth integration in a scrollable view
                    itemCount: state.historicalData.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = state.historicalData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.date,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rate:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${item.rate.toStringAsFixed(4)} ${item.toCurrencyCode}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
