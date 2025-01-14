import 'package:intl/intl.dart';

class DueDateEntity {
  final String? timezone;
  final bool? isRecurring;
  final DateTime? datetime;

  DueDateEntity({
    required this.timezone,
    required this.datetime,
    required this.isRecurring,
  });

  String? get formattedDate =>
      datetime == null ? null : DateFormat('d MMM').format(datetime!);
}
