import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String id;
  final String countryName;
  final String currencyId;
  final String currencyName;
  final String currencySymbol;
  final String countryFlag;
  //final String alpha3;

  const Currency({
    required this.id,
    required this.countryName,
    required this.currencyId,
    required this.currencyName,
    required this.currencySymbol,
    required this.countryFlag,
    //required this.alpha3,
  });

  @override
  List<Object?> get props => [id];
}
