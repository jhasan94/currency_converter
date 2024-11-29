import 'package:currency_converter/core/app_constant/app_status_code.dart';
import 'package:currency_converter/core/error_handling/exceptions.dart';
import 'package:currency_converter/core/error_handling/failureEntity.dart';

class ExceptionUtils {

  static Exception getExceptionFromStatusCode(int statusCode) {
    if (statusCode == AppStatusCode.unAuthorized) {
      return UnAuthorizedException();
    } else if (statusCode == AppStatusCode.severError) {
      return ServerException();
    } else {
      return UnknownException();
    }
  }

  static FailureEntity convertExceptionToFailure(Object e) {
    if (e is ServerException) {
      return const ServerFailure();
    } else if (e is DataParsingException) {
      return const DataParsingFailure();
    } else if (e is NoConnectionException) {
      return const NoConnectionFailure();
    } else if (e is ClientSideException) {
      return const ClientFailure();
    } else if (e is BadRequestException) {
      return BadRequestFailure(e.message);
    } else {
      return const UnknownFailure();
    }
  }
}
