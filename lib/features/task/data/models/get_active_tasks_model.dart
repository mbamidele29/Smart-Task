class GetActiveTasksModel {
  final String projectId;

  GetActiveTasksModel(this.projectId);

  Map<String, dynamic> toJson() => {'project_id': projectId};
}
