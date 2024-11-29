import 'package:equatable/equatable.dart';
import 'failureEntity.dart';

class Failure extends Equatable {
  const Failure({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  static Failure mapFailureToErrorObject({required FailureEntity failure}) {
    return failure.when(
      serverFailure: () => const Failure(
        title: "error",
        message: 'It seems that the server is not reachable at the moment, try '
            'again later',
      ),
      dataParsingFailure: () => const Failure(
        title: "error",
        message: 'It seems that the app needs to be updated to reflect the , '
            'changed server data structure, if no update is '
            'available on the store please reach out to the developer at dev@sakan.com',
      ),
      noConnectionFailure: () => const Failure(
        title: "error",
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      ),
      clientFailure: () => const Failure(
        title: 'error',
        message: 'It seems that something went wrong, '
            'please try again later.',
      ),
      unknownFailure: () => const Failure(
        title: "error",
        message: 'It seems that something went wrong, '
            'please try again later.',
      ),
      unAuthorizedFailure: () => const Failure(
        title: "error",
        message: 'It seems that you are not logged in',
      ),
      badRequestFailure: (String message) => Failure(
        title: "error",
        message: message,
      ),
    );
  }
}
