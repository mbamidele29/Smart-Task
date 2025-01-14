class CreateTaskModel {
  final String title;
  final int? priority;
  final String projectId;
  final DateTime? dueDate;
  final String? description;

  CreateTaskModel({
    required this.title,
    required this.dueDate,
    required this.priority,
    required this.projectId,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'content': title,
        'project_id': projectId,
        if (priority != null) 'priority': priority,
        if (description != null) 'description': description,
        if (dueDate != null) 'due_date': dueDate?.toIso8601String(),
      };
}
