class TaskDto {
  final String id;
  final List<String> field;
  final PositionDto start;
  final PositionDto end;

  const TaskDto(
      {required this.id,
      required this.field,
      required this.start,
      required this.end});

  factory TaskDto.fromJson(Map<String, dynamic> json) => TaskDto(
      id: json['id'] ?? '',
      field: (json['field'] as List).map((e) => e as String).toList(),
      start: PositionDto.fromJson(json['start']),
      end: PositionDto.fromJson(json['end']));
}

class PositionDto {
  final int x;
  final int y;

  const PositionDto({required this.x, required this.y});

  factory PositionDto.fromJson(Map<String, dynamic> json) =>
      PositionDto(x: json['x'] ?? 0, y: json['y'] ?? 0);
}
