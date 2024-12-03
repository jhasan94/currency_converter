import 'package:currency_converter/core/app_constant/api_end_points.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/use_case/use_case.dart';
import 'package:currency_converter/core/error_handling/failure.dart';

class ConvertCurrency extends UseCaseWithParams<String, ConvertCurrencyParams> {
  const ConvertCurrency(this._repository);
  final CurrencyConverterRepository _repository;

  @override
  FutureResult<String> call(ConvertCurrencyParams params) async {
    String code = "${params.fromCurrency}_${params.toCurrency}";
    var queryParams = {
      "q": code,
      "compact": "ultra",
      "apiKey": ApiEndPoints.apiKey
    };
    var response = await _repository.getCurrencyConvertResult(queryParams);
    return response.fold((failure) {
      return Left(failure);
    }, (success) {
      try {
        final amount = params.amount;
        if (amount <= 0) {
          return const Left(Failure(
              message: 'Amount must be greater than zero.', title: 'error'));
        }
        double rate = success.conversions[code] ?? 0.0;
        final convertedAmount = amount * rate;
        return Right(
            "${convertedAmount.toStringAsFixed(2)} ${params.toCurrency}");
      } catch (e) {
        return Left(Failure(
            message: 'An error occurred during conversion: $e',
            title: 'error'));
      }
    });
  }
}

class ConvertCurrencyParams {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  ConvertCurrencyParams({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });
}
