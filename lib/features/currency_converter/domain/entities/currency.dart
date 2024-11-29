import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String currencyCode;
  final double currencyRate;

  const Currency({required this.currencyCode, required this.currencyRate});

  @override
  List<Object?> get props => [currencyCode];
}
