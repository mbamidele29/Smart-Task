class GetTaskCommentsModel {
  final String taskId;

  GetTaskCommentsModel(this.taskId);

  Map<String, dynamic> toJson() => {'task_id': taskId};
}
