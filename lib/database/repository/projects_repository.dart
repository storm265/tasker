import 'package:todo2/database/data_source/projects_user_data.dart';
import 'package:todo2/database/model/projects_model.dart';

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
      final response = await _projectDataSource.fetchProject();

      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
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
      rethrow;
    }
  }
}
