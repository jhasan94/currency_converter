import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:currency_converter/core/app_constant/api_end_points.dart';
import 'package:currency_converter/core/app_constant/app_status_code.dart';
import 'package:currency_converter/core/network/api_client/api_interceptor.dart';
import 'package:currency_converter/core/error_handling/bad_request.dart';
import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:currency_converter/core/error_handling/exception_utils.dart';
import 'package:currency_converter/core/error_handling/exceptions.dart';

class ApiClient {
  late http.Client client;
  ApiClient() {
    client = InterceptedClient.build(
      interceptors: [ApiInterceptor()],
      requestTimeout: const Duration(seconds: 60),
    );
  }

  Future<Either<Failure, T>> handleRequest<T>({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    required T Function(String jsonData) fromRawJson,
    required RequestType method,
  }) async {
    try {
      String api = ApiEndPoints.baseUrl + endPoint;
      http.Response response;
      if (method == RequestType.get) {
        response = await _getRequest(endPoint: api, queryParams: queryParams);
      } else if (method == RequestType.post) {
        response = await _postRequest(endPoint: api, body: body!);
      } else {
        throw Exception("Unsupported Request Type");
      }
      return Right(await _handleResponse(response, fromRawJson));
    } catch (e) {
      return left(Failure.mapFailureToErrorObject(
          failure: ExceptionUtils.convertExceptionToFailure(e)));
    }
  }

  Future<T> _handleResponse<T>(
      http.Response response, T Function(String) fromRawJson) async {
    if (response.statusCode == AppStatusCode.success) {
      try {
        return fromRawJson(response.body);
      } catch (e) {
        throw DataParsingException();
      }
    } else if (response.statusCode == AppStatusCode.badRequest) {
      BadRequest errorResponse = BadRequest.fromJson(jsonDecode(response.body));
      throw BadRequestException(message: errorResponse.message);
    } else {
      throw ExceptionUtils.getExceptionFromStatusCode(response.statusCode);
    }
  }

  Future<http.Response> _getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri url = Uri.parse(endPoint).replace(queryParameters: queryParams);
    return await http.get(url);
  }

  Future<http.Response> _postRequest({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri url = Uri.parse(endPoint).replace(queryParameters: queryParams);
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
}
