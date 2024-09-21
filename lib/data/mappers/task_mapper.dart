import 'package:path_finder/data/models/task.dart';
import 'package:path_finder/domain/models/position.dart';
import 'package:path_finder/domain/models/task.dart';

extension TaskMapper on TaskDto {
  Task get toModel => Task(
      id: id,
      field: field.map((e) => e.split('')).toList(),
      start: start.toModel,
      end: end.toModel);
}

extension PositionMaper on PositionDto {
  Position get toModel => Position(x, y);
}
