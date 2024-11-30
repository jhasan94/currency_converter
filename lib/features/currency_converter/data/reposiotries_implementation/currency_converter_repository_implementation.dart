import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/data/mappers/currency_mapper.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/currency_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/currency_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';

class CurrencyConverterRepositoryImplementation
    implements CurrencyConverterRepository {
  final CurrencyRemoteDataSource currencyRemoteDataSource;
  final CurrencyLocalDataSource currencyLocalDataSource;

  const CurrencyConverterRepositoryImplementation({
    required this.currencyRemoteDataSource,
    required this.currencyLocalDataSource,
  });

  @override
  FutureResult<List<Currency>> getCurrencyList() async {
    final localData = await currencyLocalDataSource.getCurrencyList();

    final result = localData.fold<List<Currency>>(
      (failure) => [],
      (success) => CurrencyMapper.toEntity(success),
    );
    if (result.isNotEmpty) {
      return Right(result);
    }

    final remoteData = await currencyRemoteDataSource.getCurrencyList();

    return remoteData.fold(
      (failure) => Left(failure),
      (currencyModel) async {
        await currencyLocalDataSource.saveCurrencies(currencyModel);
        return right(CurrencyMapper.toEntity(currencyModel));
      },
    );
  }
}
