import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/push_notification_payload.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/push_notification/push_notification_service.dart';

class SendPushNotificationUsecase
    implements BaseUseCase<void, PushNotificationPayload> {
  final PushNotificationService pushNotificationService;

  SendPushNotificationUsecase(this.pushNotificationService);

  @override
  Future<Either<NetworkFailure, void>> call(
      PushNotificationPayload params) async {
    await pushNotificationService.showPushNotification(params);

    return Right(null);
  }
}
