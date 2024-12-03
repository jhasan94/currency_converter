import 'package:get_it/get_it.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_historical_data.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/historical_data/historical_data_bloc.dart';
import 'package:currency_converter/core/local_database/cache_manager.dart';
import 'package:currency_converter/core/local_database/database_manager.dart';
import 'package:currency_converter/core/network/api_client/api_client.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/local/currency_local_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/remote/currency_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currency_list.dart';
import 'package:currency_converter/features/currency_converter/presentation/blocs/currency_bloc/currency_bloc.dart';
import 'package:currency_converter/features/currency_converter/data/reposiotries_implementation/currency_converter_repository_implementation.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  Future<void> setUpServiceLocators() async {
    await sl.reset();

    // Core Services
    sl.registerSingleton(ApiClient());
    sl.registerSingleton(DatabaseManager());
    sl.registerSingleton(CacheManager());

    // Data Sources

    //remote
    sl.registerFactory<CurrencyRemoteDataSource>(
      () => CurrencyRemoteDataSourceImplementation(
          apiClient: sl.get<ApiClient>()),
    );

    //local
    sl.registerFactory<CurrencyLocalDataSource>(
      () => CurrencyLocalDataSourceImplementation(
          databaseManager: sl.get<DatabaseManager>(),
          cacheManager: sl.get<CacheManager>()),
    );

    // Repositories
    sl.registerFactory<CurrencyConverterRepository>(
      () => CurrencyConverterRepositoryImplementation(
          currencyLocalDataSource: sl.get<CurrencyLocalDataSource>(),
          currencyRemoteDataSource: sl.get<CurrencyRemoteDataSource>()),
    );

    // Use Cases
    sl.registerFactory<GetCurrencyList>(
      () => GetCurrencyList(sl.get<CurrencyConverterRepository>()),
    );

    sl.registerFactory<ConvertCurrency>(
      () => ConvertCurrency(sl.get<CurrencyConverterRepository>()),
    );

    sl.registerFactory<GetHistoricalData>(
      () => GetHistoricalData(sl.get<CurrencyConverterRepository>()),
    );

    // Bloc
    sl.registerFactory<CurrencyBloc>(
      () => CurrencyBloc(getCurrencyList: sl.get<GetCurrencyList>(),),
    );

    sl.registerFactory<HistoricalDataBloc>(
      () => HistoricalDataBloc(sl.get<GetHistoricalData>()),
    );
  }
}
