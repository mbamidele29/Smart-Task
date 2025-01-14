import 'package:equatable/equatable.dart';

class NetworkFailure extends Equatable {
  final String message;

  const NetworkFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
