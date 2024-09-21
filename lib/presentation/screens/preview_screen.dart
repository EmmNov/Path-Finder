import 'package:flutter/material.dart';
import 'package:path_finder/domain/models/position.dart';
import 'package:path_finder/domain/models/task.dart';
import 'package:path_finder/presentation/widgets/widgets.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final Task task = arguments['task'];
    final List<Position> path = arguments['path'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Screen'),
      ),
      body: _buildBody(task, path),
    );
  }

  Widget _buildBody(Task task, List<Position> path) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridPath(
            grid: task.field, start: task.start, end: task.end, path: path),
        PathText(path: path),
      ],
    );
  }
}

class GridPath extends StatelessWidget {
  final List<List<String>> grid;
  final Position start;
  final Position end;
  final List<Position> path;

  const GridPath({
    super.key,
    required this.grid,
    required this.start,
    required this.end,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: grid[0].length,
      ),
      itemCount: grid.length * grid[0].length,
      itemBuilder: (context, index) {
        final int x = index % grid[0].length;
        final int y = index ~/ grid[0].length;

        return GridCell(
          x: x,
          y: y,
          start: start,
          end: end,
          cellType: grid[y][x],
          isPath: path.any((p) => p.x == x && p.y == y),
        );
      },
    );
  }
}

class GridCell extends StatelessWidget {
  final int x;
  final int y;
  final Position start;
  final Position end;
  final String cellType;
  final bool isPath;

  const GridCell({
    super.key,
    required this.x,
    required this.y,
    required this.start,
    required this.end,
    required this.cellType,
    required this.isPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getCellColor(),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            "($x, $y)",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getCellColor() {
    if (x == start.x && y == start.y) {
      return const Color(0xFF64FFDA);
    } else if (x == end.x && y == end.y) {
      return const Color(0xFF009688);
    } else if (cellType != ".") {
      return Colors.black;
    } else if (isPath) {
      return const Color(0xFF4CAF50);
    } else {
      return Colors.white;
    }
  }
}
