import 'package:smart_task/features/task/domain/entities/due_date.dart';

class DueDateModel extends DueDateEntity {
  DueDateModel({super.datetime, super.timezone, super.isRecurring});

  factory DueDateModel.fromJson(Map<String, dynamic> json) => DueDateModel(
        isRecurring: json["is_recurring"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "timezone": timezone,
        "is_recurring": isRecurring,
        "datetime": datetime?.toIso8601String(),
      };
}
