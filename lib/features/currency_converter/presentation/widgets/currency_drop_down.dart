import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';

class CurrencyDropdown extends StatefulWidget {
  final List<Currency> currencies;
  final ValueChanged<Currency?>? onChanged;

  const CurrencyDropdown(
      {super.key, required this.currencies, required this.onChanged});

  @override
  CurrencyDropdownState createState() => CurrencyDropdownState();
}

class CurrencyDropdownState extends State<CurrencyDropdown> {
  Currency? selectedCurrencyRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<Currency>(
        value: selectedCurrencyRate,
        items: widget.currencies.map((currency) {
          return DropdownMenuItem<Currency>(
            alignment: AlignmentDirectional.bottomCenter,
            value: currency,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: currency.currencyFlag,
                  errorWidget: (context, url, error) => const SizedBox(),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(currency.currencyCode),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedCurrencyRate = newValue;
          });
          widget.onChanged?.call(newValue);
        },
        hint: const Text('Select Currency'),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}
