import 'package:smart_task/core/models/push_notification_payload.dart';

abstract class PushNotificationService {
  Future<void> init();
  Future<void> cancelAllNotifications();
  Future<void> cancelPushNotification(int notificationId);
  Future<void> showPushNotification(PushNotificationPayload payload,
      {bool ongoing = false});
  Future<void> schedulePushNotification(
      DateTime dateTime, PushNotificationPayload payload);
}
