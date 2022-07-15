import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/projects_user_data_source.dart';
import 'package:todo2/database/database_scheme/project_user_scheme.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ProjectRepository<T> {
  Future fetchProject();
  Future putData({
    required String color,
    required String title,
  });
  Future fetchProjectId({required String project});

  Future fetchProjectsWhere({required String title});

  Future deleteProject({required int id});

  Future updateProject({required ProjectModel projectModel});
}

class ProjectRepositoryImpl implements ProjectRepository<ProjectModel> {
  final _projectDataSource = ProjectUserDataImpl();
  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final response = await _projectDataSource.fetchProject();
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProject() repository $e');
      rethrow;
    }
  }

  @override
  Future<void> putData({
    required String color,
    required String title,
  }) async {
    try {
      await _projectDataSource.putData(
        color: color,
        title: title,
      );
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl putData() repository $e');
      rethrow;
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjectsWhere({required String title}) async {
    try {
      final response =
          await _projectDataSource.fetchProjectsWhere(title: title);
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProjectsWhere() : $e');
      rethrow;
    }
  }

  @override
  Future<int> fetchProjectId({required String project}) async {
    try {
      final response =
          await _projectDataSource.fetchProjectId(project: project);
      return response.data[0][ProjectDataScheme.id];
    } catch (e) {
      ErrorService.printError(
          'Error in ProjectRepositoryImpl fetchProjectId() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse> updateProject(
      {required ProjectModel projectModel}) async {
    try {
      final response =
          await _projectDataSource.updateProject(projectModel: projectModel);
      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource removeProject() : $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> deleteProject({required int id}) async {
    try {
      final response = await _projectDataSource.deleteProject(id: id);
      return response;
    } catch (e) {
      ErrorService.printError('Error in dataSource removeProject() : $e');
      rethrow;
    }
  }
}
