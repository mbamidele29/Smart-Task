import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';

abstract class BaseUseCase<Response, Request> {
  Future<Either<NetworkFailure, Response>> call(Request request);
}
