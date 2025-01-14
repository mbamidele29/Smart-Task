class CreateProjectModel {
  final String name;

  CreateProjectModel(this.name);

  Map<String, dynamic> toJson() => {'name': name};
}
