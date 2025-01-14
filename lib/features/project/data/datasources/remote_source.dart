import 'package:dio/dio.dart';
import 'package:smart_task/core/data/source/network/http_service.dart';
import 'package:smart_task/core/exceptions/server_exception.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/data/models/project.dart';

abstract class ProjectRemoteSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> createProject(CreateProjectModel request);
}

class ProjectRemoteSourceImpl extends ProjectRemoteSource {
  final HttpService service;
  final String _endpoint = 'rest/v2/projects';

  ProjectRemoteSourceImpl(this.service);

  @override
  Future<ProjectModel> createProject(CreateProjectModel request) async {
    Response response = await service.post(_endpoint, data: request.toJson());
    if (response.isSuccessful) {
      return ProjectModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProjectModel>> getProjects() async {
    Response response = await service.getRequest(_endpoint);
    if (response.isSuccessful) {
      return (response.data as List)
          .map((e) => ProjectModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
