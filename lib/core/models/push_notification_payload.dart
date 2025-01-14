class PushNotificationPayload {
  final int id;
  final String body;
  final String title;

  PushNotificationPayload(
      {required this.id, required this.body, required this.title});

  Map<String, dynamic> toJson() => {'id': id, 'body': body, 'title': title};
}
