import 'package:path_finder/domain/models/grid.dart';
import 'package:path_finder/domain/models/position.dart';

class PathFinder {
  final Grid grid;
  final List<Position> directions = [
    const Position(0, 1),
    const Position(0, -1),
    const Position(1, 0),
    const Position(-1, 0),
    const Position(1, 1),
    const Position(-1, -1),
    const Position(1, -1),
    const Position(-1, 1)
  ];

  PathFinder({required this.grid});

  List<Position> findPath(Position start, Position end) {
    List<Position> queue = [];
    queue.add(start);

    Map<Position, Position?> from = {};
    from[start] = null;

    while (queue.isNotEmpty) {
      Position current = queue.removeAt(0);

      if (current == end) {
        return _reconstructPath(from, end);
      }

      for (Position dir in directions) {
        Position nextPoint = Position(current.x + dir.x, current.y + dir.y);

        if (grid.isWalkable(nextPoint) && !from.containsKey(nextPoint)) {
          queue.add(nextPoint);
          from[nextPoint] = current;
        }
      }
    }
    return [];
  }

  List<Position> _reconstructPath(Map<Position, Position?> from, Position end) {
    List<Position> path = [];
    Position? current = end;

    while (current != null) {
      path.add(current);
      current = from[current];
    }
    return path.reversed.toList();
  }
}
