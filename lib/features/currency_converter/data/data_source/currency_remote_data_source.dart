import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/app_constant/api_end_points.dart';
import 'package:currency_converter/core/network/api_client/api_client.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  FutureResult<CurrencyModel> getCurrencyList();
}

class CurrencyRemoteDataSourceImplementation
    implements CurrencyRemoteDataSource {
  final ApiClient apiClient;

  CurrencyRemoteDataSourceImplementation({required this.apiClient});

  @override
  FutureResult<CurrencyModel> getCurrencyList() async {
    final response = await apiClient.handleRequest<CurrencyModel>(
      endPoint: ApiEndPoints.currency,
      queryParams: null,
      fromJson: CurrencyModel.fromJson,
      method: RequestType.get,
    );
    return response;
  }
}
