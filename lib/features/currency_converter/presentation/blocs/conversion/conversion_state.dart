import 'package:equatable/equatable.dart';

abstract class ConversionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConversionInitial extends ConversionState {}

class ConversionLoading extends ConversionState {}

class ConversionSuccess extends ConversionState {
  final double convertedAmount;

  ConversionSuccess({required this.convertedAmount});

  @override
  List<Object?> get props => [convertedAmount];
}

class ConversionError extends ConversionState {
  final String message;

  ConversionError({required this.message});

  @override
  List<Object?> get props => [message];
}
