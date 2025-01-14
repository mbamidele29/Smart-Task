import 'dart:convert';

import 'package:smart_task/core/data/source/local/storage.dart';
import 'package:smart_task/features/project/data/models/project.dart';

abstract class ProjectLocalSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel?> getCurrentProject();
  Future<void> setCurrentProject(ProjectModel project);
  Future<void> saveProjects(List<ProjectModel> projects);
}

class ProjectLocalSourceImpl extends ProjectLocalSource {
  final LocalStorage storage;
  final String projectsKey = 'PROJECTS_KEY';
  final String currentProjectsKey = 'CURRENT_PROJECT_KEY';

  ProjectLocalSourceImpl(this.storage);

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      List<ProjectModel> projects = [];
      String? value = storage.read(projectsKey);
      if (value != null) {
        projects = (jsonDecode(value) as List)
            .map((json) => ProjectModel.fromJson(json))
            .toList();
      }
      return projects;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveProjects(List<ProjectModel> projects) async {
    await storage.save(
        key: projectsKey,
        value: jsonEncode(projects.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> setCurrentProject(ProjectModel project) async {
    await storage.save(
        key: currentProjectsKey, value: jsonEncode(project.toJson()));
  }

  @override
  Future<ProjectModel?> getCurrentProject() async {
    try {
      String? value = storage.read(currentProjectsKey);
      if (value != null) {
        return ProjectModel.fromJson(jsonDecode(value));
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
