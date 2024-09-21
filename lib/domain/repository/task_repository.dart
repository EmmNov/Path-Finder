import 'package:path_finder/domain/models/task.dart';
import 'package:path_finder/domain/models/task_request.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getTasks();
  Future sendResultingData(List<TaskRequest> taskRequest);
}
