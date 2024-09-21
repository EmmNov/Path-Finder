import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_finder/domain/algorithms/path_finder.dart';
import 'package:path_finder/domain/models/grid.dart';
import 'package:path_finder/domain/models/position.dart';
import 'package:path_finder/domain/models/task.dart';
import 'package:path_finder/domain/models/task_request.dart';
import 'package:path_finder/domain/repository/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._taskRepository) : super(const TasksState());

  final TaskRepository _taskRepository;

  Future<void> getTasks() async {
    _resetState();
    try {
      final tasks = await _taskRepository.getTasks();
      emit(state.copyWith(tasks: tasks, status: TasksStatus.succses));
      await startCouting();
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: TasksStatus.failure));
    }
  }

  startCouting() async {
    try {
      final tasksCount = state.tasks.length;
      for (final task in state.tasks) {
        Grid grid = Grid(task.field);
        PathFinder pathFinder = PathFinder(grid: grid);
        List<List<Position>> coutingPaths = List.from(state.coutingPaths);
        coutingPaths.add(pathFinder.findPath(task.start, task.end));
        final progresValue = state.progresValue + 100 / tasksCount;
        emit(state.copyWith(
            coutingPaths: coutingPaths, progresValue: progresValue));
        await Future.delayed(const Duration(milliseconds: 250));
      }
      emit(state.copyWith(status: TasksStatus.counted, progresValue: 100));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure, error: e.toString()));
    }
  }

  Future<void> sendResult() async {
    try {
      emit(state.copyWith(status: TasksStatus.sending));
      if (state.coutingPaths.isEmpty) {
        emit(state.copyWith(
            status: TasksStatus.failure, error: 'There is no unsolved task'));
        return;
      }
      final taskRequest = List.generate(
          state.tasks.length,
          (index) => TaskRequest(
              id: state.tasks[index].id, steps: state.coutingPaths[index]));
      await _taskRepository.sendResultingData(taskRequest);
      emit(state.copyWith(status: TasksStatus.send));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure, error: e.toString()));
    }
  }

  void _resetState() {
    emit(state.copyWith(
        tasks: [],
        progresValue: 0,
        status: TasksStatus.initial,
        coutingPaths: []));
  }
}
