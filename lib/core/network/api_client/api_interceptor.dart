import 'dart:async';
import 'dart:developer';
import 'package:http_interceptor/http_interceptor.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  BaseRequest interceptRequest({
    required BaseRequest request,
  }) {
    request.headers['content-type'] = 'application/json';
    log("-----------------------------------------------------------------------");
    log("---${request.method} URL: ${request.url}      \n");
    log("- - - - - - ");
    log("HEADERS: ${request.headers}\n");
    log("- - - - - - ");
    log('----- Request -----');
    log('Request type: ${request.runtimeType}');
    log('Request data: $request');
    log("-----------------------------------------------------------------------");
    return request;
  }

  @override
  BaseResponse interceptResponse({
    required BaseResponse response,
  }) {
    log('----- Response -----');
    log('Code: ${response.statusCode}');
    log('Response type: ${response.runtimeType}');
    log("-----------------------------------------------------------------------");
    if (response is Response) {
      log((response).body);
    } else {
      log('------------------no body response-----------------');
    }
    log("------------------------------------------------------------------------");
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
