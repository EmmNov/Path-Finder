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

    Map<Position, Position?> parentMap = {};
    parentMap[start] = null;

    while (queue.isNotEmpty) {
      Position current = queue.removeAt(0);

      if (current == end) {
        return _reconstructPath(parentMap, end);
      }

      for (Position dir in directions) {
        Position nextPosition = Position(current.x + dir.x, current.y + dir.y);

        if (grid.isWalkable(nextPosition) &&
            !parentMap.containsKey(nextPosition)) {
          queue.add(nextPosition);
          parentMap[nextPosition] = current;
        }
      }
    }
    return [];
  }

  List<Position> _reconstructPath(
      Map<Position, Position?> parentMap, Position end) {
    List<Position> path = [];
    Position? current = end;

    while (current != null) {
      path.add(current);
      current = parentMap[current];
    }
    return path.reversed.toList();
  }
}
