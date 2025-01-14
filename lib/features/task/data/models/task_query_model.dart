class TaskQueryModel {
  final String projectId;

  TaskQueryModel(this.projectId);

  Map<String, dynamic> toJson() => {'project_id': projectId};
}
