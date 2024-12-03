import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'CurrencyConverterRepository.mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/core/app_constant/api_end_points.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_coversion_enitty.dart';

void main() {
  late MockCurrencyConverterRepository mockRepository;
  late ConvertCurrency useCase;

  setUp(() {
    mockRepository = MockCurrencyConverterRepository();
    useCase = ConvertCurrency(mockRepository);
  });

  test('Should call getCurrencyConvertResult with correct query parameters',
      () async {
    // Arrange
    var params = ConvertCurrencyParams(
      fromCurrency: 'USD',
      toCurrency: 'BDT',
      amount: 100.0,
    );
    const expectedRate = 120.0;
    final queryParams = {
      "q": "USD_BDT",
      "compact": "ultra",
      "apiKey": ApiEndPoints.apiKey,
    };

    final mockResult = CurrencyConversionEntity(conversions: {
      'USD_BDT': expectedRate,
    });

    when(() => mockRepository.getCurrencyConvertResult(queryParams))
        .thenAnswer((_) async => Right(mockResult));

    // Act
    final result = await useCase(params);

    // Assert
    verify(() => mockRepository.getCurrencyConvertResult(queryParams))
        .called(1);
    result.fold(
      (failure) => fail('Test failed with error: ${failure.message}'),
      (convertedAmount) {
        expect(convertedAmount, equals('12000.00 BDT'));
      },
    );
  });
}
