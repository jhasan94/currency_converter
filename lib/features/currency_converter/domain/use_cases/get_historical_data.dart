import 'package:currency_converter/core/app_secret.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/use_case/use_case.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:dartz/dartz.dart';

class GetHistoricalData extends UseCaseWithParams<List<CurrencyRate>, HistoricalDataParams> {
  const GetHistoricalData(this._repository);
  final CurrencyConverterRepository _repository;
  @override
  FutureResult<List<CurrencyRate>> call(HistoricalDataParams params) async {
    var response = await _repository.getHistoricalData(params.toJson());
    return response.fold(
            (failure) {
      return Left(failure);
    },
            (success) {
      for (var item in success) {
        item.rate = item.rate * params.amount;
        item.toCurrencyCode = params.toCurrency;
      }
      return Right(success);
    });
  }
}

class HistoricalDataParams {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  HistoricalDataParams({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  String formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Map<String, dynamic> toJson() {
    final code = "${fromCurrency}_$toCurrency";
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(const Duration(days: 6));
    return {
      "q": code,
      "compact": "ultra",
      "apiKey": AppSecret.apiKey,
      "date": formatDate(startDate),
      "endDate": formatDate(currentDate),
    };
  }
}
