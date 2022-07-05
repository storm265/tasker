import 'package:todo2/database/data_source/projects_user_data_source.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ProjectRepository<T> {
  Future fetchProject();
  Future putData({
    required String color,
    required String title,
  });
}

class ProjectRepositoryImpl implements ProjectRepository<ProjectModel> {
  final _projectDataSource = ProjectUserDataImpl();
  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final response = await _projectDataSource.fetchMyProjects();

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

   Future<List<ProjectModel>> fetchProjects({required String title}) async {
    try {
      final response = await _projectDataSource.fetchProjects(title: title);
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in ------ fetchProjects() ------ $e');
      rethrow;
    }
  }
}
