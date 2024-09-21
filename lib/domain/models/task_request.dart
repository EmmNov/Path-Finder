import 'package:path_finder/domain/models/position.dart';

class TaskRequest {
  final String id;
  final List<Position> steps;

  TaskRequest({
    required this.id,
    required this.steps,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "result": {
        "steps":
            steps.map((step) => {'x': '${step.x}', 'y': '${step.y}'}).toList(),
        "path": _formatedPath
      }
    };
  }

  String get _formatedPath =>
      steps.map((e) => '(${e.x},${e.y})').toList().join('->');
}
