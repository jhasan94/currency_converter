import 'package:currency_converter/core/network/api_client/api_client.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/currency_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/reposiotries_implementation/currency_converter_repository_implementation.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_reposiotry.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/get_currency_list.dart';
import 'package:currency_converter/features/currency_converter/presentation/controller/currency_controller.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  Future<void> setUpServiceLocators() async {
    await sl.reset();
    sl.registerSingleton(ApiClient());
    sl.registerFactory<CurrencyRemoteDataSource>(
        () => CurrencyRemoteDataSourceImplementation(apiClient: sl.get<ApiClient>()));
    sl.registerFactory<CurrencyConverterRepository>(() =>
        CurrencyConverterRepositoryImplementation(
            dataSourceImplementation: sl.get<CurrencyRemoteDataSource>()));
    sl.registerFactory<GetCurrencyList>(()=>GetCurrencyList(sl.get<CurrencyConverterRepository>()));
  }
}
