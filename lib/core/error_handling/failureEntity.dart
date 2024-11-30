import 'package:freezed_annotation/freezed_annotation.dart';
part 'failureEntity.freezed.dart';

@freezed
class FailureEntity with _$FailureEntity {
  const FailureEntity._();
  const factory FailureEntity.serverFailure() = ServerFailure;
  const factory FailureEntity.dataParsingFailure() = DataParsingFailure;
  const factory FailureEntity.noConnectionFailure() = NoConnectionFailure;
  const factory FailureEntity.clientFailure() = ClientFailure;
  const factory FailureEntity.unknownFailure() = UnknownFailure;
  const factory FailureEntity.unAuthorizedFailure() = UnAuthorizedFailure;
  const factory FailureEntity.badRequestFailure(String message) =
      BadRequestFailure;
}
