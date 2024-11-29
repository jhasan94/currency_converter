import 'package:currency_converter/core/app_constant/api_end_points.dart';
import 'package:currency_converter/core/network/api_client/api_client.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/data/mappers/currency_mapper.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/features/currency_converter/domain/entities/currency.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRemoteDataSource {
  FutureResult<List<Currency>> getCurrencyList();
}

class CurrencyRemoteDataSourceImplementation
    implements CurrencyRemoteDataSource {
  final ApiClient apiClient;

  CurrencyRemoteDataSourceImplementation({required this.apiClient});

  @override
  FutureResult<List<Currency>> getCurrencyList() async {
    final response = await apiClient.handleRequest<CurrencyModel>(
      endPoint: ApiEndPoints.currency,
      queryParams: null,
      fromJson: CurrencyModel.fromJson,
      method: RequestType.get,
    );
    return response.fold(
      (failure) => Left(failure),
      (currencyModel) => right(CurrencyMapper.toEntity(currencyModel)),
    );
  }
}
