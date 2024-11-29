import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class DataParsingException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class NoConnectionException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class ClientSideException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UnknownException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UnAuthorizedException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class BadRequestException extends Equatable implements Exception {
  final String message;
  const BadRequestException({required this.message});
  @override
  List<Object?> get props => [];
}
