import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/domain/models/position.dart';
import 'package:path_finder/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:path_finder/presentation/navigation/routes.dart';
import 'package:path_finder/presentation/widgets/widgets.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  static const String _title = 'Result List Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: const ResultList(),
    );
  }
}

class ResultList extends StatelessWidget {
  const ResultList({super.key});
  static const String _emptyListMessage = 'No results available.';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state.coutingPaths.isEmpty) {
          return const Center(child: Text(_emptyListMessage));
        }

        return ListView.separated(
          itemCount: state.coutingPaths.length,
          itemBuilder: (context, index) {
            return ResultListItem(
              index: index,
              path: state.coutingPaths[index],
              task: state.tasks[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
        );
      },
    );
  }
}

class ResultListItem extends StatelessWidget {
  final int index;
  final List<Position> path;
  final dynamic task;

  const ResultListItem({
    super.key,
    required this.index,
    required this.path,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _navigateToPreviewScreen(context),
      title: PathText(path: path),
    );
  }

  void _navigateToPreviewScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.previewScreen,
      arguments: {
        'task': task,
        'path': path,
      },
    );
  }
}
