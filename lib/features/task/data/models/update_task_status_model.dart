class UpdateTaskStatusModel {
  final String id;
  final int? durationInMinute;

  UpdateTaskStatusModel({required this.id, required this.durationInMinute});

  Map<String, dynamic> toJson() => {
        if (durationInMinute != null) 'duration_unit': 'minute',
        'duration': durationInMinute,
      };
}
