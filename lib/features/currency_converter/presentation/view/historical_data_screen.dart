import 'package:currency_converter/features/currency_converter/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HistoricalDataScreen extends StatelessWidget {
  const HistoricalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: customAppBar(title: 'Historical Data'),
      body: const Center(
        child: Text('Historical Data Chart Placeholder'),
      ),
    );
  }
}
