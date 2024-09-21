import 'package:path_finder/domain/models/position.dart';

class Grid {
  final List<List<String>> grid;

  Grid(this.grid) {
    if (numRows <= 1 || numRows >= 100) {
      throw ArgumentError(
          'Number of rows must be greater than 1 and less than 100.');
    }
    if (numCols <= 1 || numCols >= 100) {
      throw ArgumentError(
          'Number of columns must be greater than 1 and less than 100.');
    }
  }

  int get numRows => grid.length;
  int get numCols => grid[0].length;

  bool isWalkable(Position point) {
    return point.x >= 0 &&
        point.x < numCols &&
        point.y >= 0 &&
        point.y < numRows &&
        grid[point.y][point.x] == '.';
  }
}
