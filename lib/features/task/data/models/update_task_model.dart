class UpdateTaskModel {
  final String id;
  final int? priority;
  final int? duration;
  final String? title;
  final DateTime? dueDate;
  final String? description;
  final List<String>? labels;

  UpdateTaskModel(
      {this.title,
      this.labels,
      this.dueDate,
      this.priority,
      this.duration,
      required this.id,
      this.description});

  Map<String, dynamic> toJson() => {
        if (title != null) 'content': title,
        if (labels != null) 'labels': labels,
        if (priority != null) 'priority': priority,
        if (duration != null) ...{
          'duration': duration,
          'duration_unit': 'minute'
        },
        if (description != null) 'description': description,
        if (dueDate != null) 'due_date': dueDate?.toIso8601String(),
      };
}
