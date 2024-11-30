import 'package:currency_converter/features/currency_converter/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'core/service_locator/service_locator.dart';

Future<void> main() async {
  await ServiceLocator().setUpServiceLocators();
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
