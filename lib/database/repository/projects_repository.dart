import 'package:todo2/database/data_source/projects_user_data.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class ProjectRepository<T> {
  Future<T> fetchProject();
  Future<T> putData({
    required String color,
    required String title,
  });
}

class ProjectRepositoryImpl implements ProjectRepository {
  final _projectDataSource = ProjectUserDataImpl();
  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final _responce = await _projectDataSource.fetchProject();

      return (_responce.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchProject() repository $e');
    }
    throw Exception('Error in fetchProject() repository');
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
      ErrorService.printError('Error in putData() repository $e');
    }
  }
}
