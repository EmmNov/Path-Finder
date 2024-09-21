import 'package:equatable/equatable.dart';
import 'package:path_finder/domain/models/position.dart';

class Task extends Equatable {
  final String id;
  final List<List<String>> field;
  final Position start;
  final Position end;

  const Task(
      {required this.id,
      required this.field,
      required this.start,
      required this.end});

  static const empty =
      Task(id: '', field: [], start: Position.empty, end: Position.empty);
  @override
  List<Object?> get props => [id, field, start, end];
}
