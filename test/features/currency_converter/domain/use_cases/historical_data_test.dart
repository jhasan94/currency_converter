import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'CurrencyConverterRepository.mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_historical_data.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';

void main() {
  late MockCurrencyConverterRepository mockRepository;
  late GetHistoricalData getHistoricalData;

  setUp(() {
    mockRepository = MockCurrencyConverterRepository();
    getHistoricalData = GetHistoricalData(mockRepository);
  });

  group('GetHistoricalData use case', () {
    final historicalDataParams = HistoricalDataParams(
      fromCurrency: 'USD',
      toCurrency: 'BDT',
      amount: 100.0,
    );

    final mockCurrencyRateData = [
      CurrencyRate(date: '2024-11-25', rate: 119.5),
      CurrencyRate(date: '2024-11-26', rate: 119.0),
      CurrencyRate(date: '2024-11-27', rate: 118.8),
      CurrencyRate(date: '2024-11-28', rate: 119.2),
      CurrencyRate(date: '2024-11-29', rate: 119.4),
      CurrencyRate(date: '2024-11-30', rate: 119.1),
      CurrencyRate(date: '2024-12-01', rate: 119.3),
    ];

    test('should return historical data successfully', () async {
      // Arrange
      when(() =>
              mockRepository.getHistoricalData(historicalDataParams.toJson()))
          .thenAnswer((_) async => Right(mockCurrencyRateData));

      // Act
      final result = await getHistoricalData(historicalDataParams);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected success, but got failure'),
        (historicalRates) {
          expect(historicalRates.length, 7);
          expect(historicalRates[0].rate, 119.5 * historicalDataParams.amount);
          expect(historicalRates[1].rate, 119.0 * historicalDataParams.amount);
        },
      );
    });

    test('should return failure if repository call fails', () async {
      // Arrange
      when(() => mockRepository.getHistoricalData(historicalDataParams.toJson()))
          .thenAnswer((_) async => const Left(Failure(message: 'Error', title: 'error')));

      // Act
      final result = await getHistoricalData(historicalDataParams);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, 'Error'),
        (historicalRates) => fail('Expected failure, but got success'),
      );
    });
  });
}
