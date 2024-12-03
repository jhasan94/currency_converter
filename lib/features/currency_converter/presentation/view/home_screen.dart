import 'package:flutter/material.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/app_bar.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/custom_option_card.dart';
import 'package:currency_converter/features/currency_converter/presentation/view/currency_converter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: customAppBar(title: 'Currency Converter'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose an option below to get started:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            CustomOptionCard(
              title: 'Currency Converter',
              icon: Icons.currency_exchange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurrencyConverterScreen(),
                  ),
                );
              },
            ),
            // const SizedBox(height: 20),
            // CustomOptionCard(
            //   title: 'Historical Data',
            //   icon: Icons.bar_chart,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const HistoricalDataScreen(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
