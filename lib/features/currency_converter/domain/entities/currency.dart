import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String currencyCode;
  final double currencyRate;
  final String currencyFlag;

  const Currency(
      {required this.currencyCode,
      required this.currencyRate,
      required this.currencyFlag});

  @override
  List<Object?> get props => [currencyCode];
}
