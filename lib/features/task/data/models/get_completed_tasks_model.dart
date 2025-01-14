class GetCompletedTasksModel {
  final String projectId;

  GetCompletedTasksModel(this.projectId);

  Map<String, dynamic> toJson() =>
      {'project_id': projectId, 'annotate_items': true};
}
