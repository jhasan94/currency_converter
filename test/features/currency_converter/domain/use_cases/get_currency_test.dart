import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'CurrencyConverterRepository.mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_reposiotry.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currency_list.dart';

void main() {
  late CurrencyConverterRepository repository;
  late GetCurrencyList useCases;
  setUpAll(() {
    repository = MockCurrencyConverterRepository();
    useCases = GetCurrencyList(repository);
  });

  const List<Currency> tCurrencyList = [];
  test("call get currency list and it will return list currency", () async {
    when(() => repository.getCurrencyList())
        .thenAnswer((_) async => const Right(tCurrencyList));

    final result = await useCases();

    expect(result, equals(const Right<dynamic, List<Currency>>(tCurrencyList)));
    verify(() => repository.getCurrencyList()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
