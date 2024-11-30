import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/use_case/use_case.dart';
import 'package:currency_converter/core/error_handling/failure.dart';

class ConvertCurrency extends UseCaseWithParams<double, ConvertCurrencyParams> {
  const ConvertCurrency();

  @override
  FutureResult<double> call(ConvertCurrencyParams params) async {
    try {
      final fromRate = params.fromRate;
      final toRate = params.toRate;
      final amount = params.amount;

      if (fromRate <= 0 || toRate <= 0) {
        return const Left(
            Failure(message: 'Invalid currency rates.', title: 'error'));
      }

      if (amount <= 0) {
        return const Left(Failure(
            message: 'Amount must be greater than zero.', title: 'error'));
      }

      final baseAmount = amount / fromRate;
      final convertedAmount = baseAmount * toRate;

      return Right(convertedAmount);
    } catch (e) {
      return Left(Failure(
          message: 'An error occurred during conversion: $e', title: 'error'));
    }
  }
}

class ConvertCurrencyParams {
  final double fromRate;
  final double toRate;
  final double amount;

  ConvertCurrencyParams({
    required this.fromRate,
    required this.toRate,
    required this.amount,
  });
}
