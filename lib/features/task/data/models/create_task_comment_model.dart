class CreateTaskCommentModel {
  final String taskId;
  final String comment;

  CreateTaskCommentModel({required this.taskId, required this.comment});

  Map<String, dynamic> toJson() => {'task_id': taskId, 'content': comment};
}
