import 'package:flutter/material.dart';
import 'package:path_finder/domain/models/position.dart';

class PathText extends StatelessWidget {
  final List<Position> path;

  const PathText({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Text(
      path.map((e) => e.toString()).join('->'),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
