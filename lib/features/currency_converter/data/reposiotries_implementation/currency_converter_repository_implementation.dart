import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/data/data_source/currency_remote_data_source.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_reposiotry.dart';

class CurrencyConverterRepositoryImplementation
    implements CurrencyConverterRepository {
  final CurrencyRemoteDataSource dataSourceImplementation;
  const CurrencyConverterRepositoryImplementation(
      {required this.dataSourceImplementation});
  @override
  FutureResult<List<Currency>> getCurrencyList() {
    return dataSourceImplementation.getCurrencyList();
  }
}
