class CurrencyHistoricalEntity {
  final String currencyPair;
  final List<CurrencyRate> historicalRates;

  const CurrencyHistoricalEntity({
    required this.currencyPair,
    required this.historicalRates,
  });
}

class CurrencyRate {
  final String date;
  double rate;
  String toCurrencyCode;

  CurrencyRate({
    required this.date,
    required this.rate,
    this.toCurrencyCode = '',
  });
}
