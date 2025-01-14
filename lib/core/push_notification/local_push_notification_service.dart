import 'dart:convert';
import 'dart:io';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_task/core/models/push_notification_payload.dart';
import 'package:smart_task/core/push_notification/push_notification_service.dart';

class LocalPushNotificationService extends PushNotificationService {
  final String channelId = 'task_track';
  final String channelName = "smart_task";
  final String channelDescription = 'task reminder';

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  @override
  Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings()));

    tz.initializeTimeZones();
  }

  @override
  Future<void> schedulePushNotification(
      DateTime dateTime, PushNotificationPayload payload) async {
    final DateTime now = DateTime.now();
    Duration duration = now.isAfter(dateTime)
        ? now.difference(dateTime)
        : dateTime.difference(now);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        payload.id,
        payload.title,
        payload.body,
        tz.TZDateTime.now(tz.local).add(duration),
        NotificationDetails(
            android: AndroidNotificationDetails(channelId, channelName,
                priority: Priority.high,
                importance: Importance.max,
                channelDescription: channelDescription)),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Future<void> showPushNotification(PushNotificationPayload payload,
      {bool ongoing = false}) async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    await _flutterLocalNotificationsPlugin.show(
        payload.id,
        payload.title,
        payload.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            ongoing: ongoing,
            priority: Priority.high,
            importance: Importance.max,
            channelDescription: channelDescription,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            badgeNumber: 1,
          ),
        ),
        payload: jsonEncode(payload.toJson()));
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Future<void> cancelPushNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
