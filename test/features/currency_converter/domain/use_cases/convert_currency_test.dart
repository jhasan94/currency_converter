import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConvertCurrency extends Mock implements ConvertCurrency {}

void main() {
  late ConvertCurrency convertCurrency;

  setUp(() {
    convertCurrency = const ConvertCurrency();
  });

  group('ConvertCurrency Use Case', () {
    const double validFromRate = 0.85;
    const double validToRate = 1.10;
    const double validAmount = 100.0;

    test('should return converted amount when parameters are valid', () async {
      // Arrange
      const expectedConvertedAmount = (validAmount / validFromRate) * validToRate;
      final params = ConvertCurrencyParams(
        fromRate: validFromRate,
        toRate: validToRate,
        amount: validAmount,
      );

      // Act
      final result = await convertCurrency(params);

      // Assert
      expect(result, equals(const Right(expectedConvertedAmount)));
    });

    test('should return failure if fromRate is invalid (<= 0)', () async {
      // Arrange
      const invalidFromRate = 0.0;
      final params = ConvertCurrencyParams(
        fromRate: invalidFromRate,
        toRate: validToRate,
        amount: validAmount,
      );

      // Act
      final result = await convertCurrency(params);

      // Assert
      expect(result, equals(const Left(Failure(
        title: 'error',
        message: 'Invalid currency rates.',
      ))));
    });

    test('should return failure if toRate is invalid (<= 0)', () async {
      // Arrange
      const invalidToRate = 0.0;
      final params = ConvertCurrencyParams(
        fromRate: validFromRate,
        toRate: invalidToRate,
        amount: validAmount,
      );

      // Act
      final result = await convertCurrency(params);

      // Assert
      expect(result, equals(const Left(Failure(
        title: 'error',
        message: 'Invalid currency rates.',
      ))));
    });

    test('should return failure if amount is invalid (<= 0)', () async {
      // Arrange
      const invalidAmount = 0.0;
      final params = ConvertCurrencyParams(
        fromRate: validFromRate,
        toRate: validToRate,
        amount: invalidAmount,
      );

      // Act
      final result = await convertCurrency(params);

      // Assert
      expect(result, equals(const Left(Failure(
        title: 'error',
        message: 'Amount must be greater than zero.',
      ))));
    });
  });
}
