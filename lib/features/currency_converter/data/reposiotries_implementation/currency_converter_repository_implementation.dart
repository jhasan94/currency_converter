import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_coversion_enitty.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency_historical_entity.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/local/currency_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/remote/currency_remote_data_source.dart';
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

    final cachedCurrencies = localData.fold<List<Currency>>(
      (failure) => [],
      (currencyModel) => currencyModel,
    );

    if (cachedCurrencies.isNotEmpty) {
      return Right(cachedCurrencies);
    }

    final remoteData = await currencyRemoteDataSource.getCurrencyList();

    return remoteData.fold(
      (failure) => Left(failure),
      (data) async {
        try {
          await currencyLocalDataSource.saveCurrencies(data);
        } catch (_) {}
        return Right(data);
      },
    );
  }

  @override
  FutureResult<CurrencyConversionEntity> getCurrencyConvertResult(Map<String,dynamic> params) async {
    final remoteData = await currencyRemoteDataSource.getConversionResult(params);
    return remoteData.fold(
      (failure) => Left(failure),
      (data) => Right(data.toEntity()),
    );
  }

  @override
  FutureResult<List<CurrencyRate>> getHistoricalData(Map<String, dynamic> params) async{
    final remoteData = await currencyRemoteDataSource.getHistoricalData(params);
    return remoteData.fold(
          (failure) => Left(failure),
          (data) => Right(data.historicalRates),
    );
  }
}
