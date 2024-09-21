part of 'tasks_cubit.dart';

enum TasksStatus { initial, succses, counting, counted, sending, send, failure }

extension TasksStatusX on TasksStatus {
  bool get isInitial => this == TasksStatus.initial;
  bool get isSuccses => this == TasksStatus.succses;
  bool get isCounting => this == TasksStatus.counting;
  bool get isCounted => this == TasksStatus.counted;
  bool get isSending => this == TasksStatus.sending;
  bool get isSend => this == TasksStatus.send;
  bool get isFailure => this == TasksStatus.failure;
}

class TasksState extends Equatable {
  const TasksState(
      {this.status = TasksStatus.initial,
      this.tasks = const [],
      this.coutingPaths = const [],
      this.progresValue = 0,
      this.error = ''});

  final TasksStatus status;
  final List<Task> tasks;
  final List<List<Position>> coutingPaths;

  final double progresValue;

  final String error;

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    List<List<Position>>? coutingPaths,
    double? progresValue,
    String? error,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      coutingPaths: coutingPaths ?? this.coutingPaths,
      progresValue: progresValue ?? this.progresValue,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, tasks, coutingPaths, progresValue, error];
}
