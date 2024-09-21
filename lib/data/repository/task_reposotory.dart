import 'package:path_finder/data/data_sourses/task_api_client.dart';
import 'package:path_finder/data/mappers/task_mapper.dart';
import 'package:path_finder/domain/models/task.dart';
import 'package:path_finder/domain/models/task_request.dart';
import 'package:path_finder/domain/repository/task_repository.dart';
import 'package:path_finder/domain/repository/url_repository.dart';

class TaskReposotoryImpl implements TaskRepository {
  final TaskApiClient _taskApiClient;

  TaskReposotoryImpl(this._urlRepository, {TaskApiClient? taskApiClient})
      : _taskApiClient = taskApiClient ?? TaskApiClient();

  final UrlRepository _urlRepository;

  @override
  Future<List<Task>> getTasks() async {
    final url = await _urlRepository.getUrl();
    final task = await _taskApiClient.getData(url);

    return task.map((e) => e.toModel).toList();
  }

  @override
  Future sendResultingData(List<TaskRequest> request) async {
    final url = await _urlRepository.getUrl();

    await _taskApiClient.sendResultingData(
        url, request.map((e) => e.toJson()).toList());
  }
}
