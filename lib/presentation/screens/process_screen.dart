import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:path_finder/presentation/navigation/routes.dart';
import 'package:path_finder/presentation/widgets/action_button.dart';
import 'package:path_finder/presentation/widgets/radial_progres_indicator.dart';

class ProcesScreen extends StatelessWidget {
  const ProcesScreen({super.key});

  static const String title = 'Process screen';
  static const String actionButtonLabel = 'Send result to server';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state.status.isSending) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isFailure) {
          return Center(child: Text(state.error, textAlign: TextAlign.center));
        }
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: ProcessContent()),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state.status.isSend) {
          Navigator.pushReplacementNamed(context, AppRoutes.resultListScreen);
        }
      },
      builder: (context, state) {
        if (state.status.isCounted || state.status.isFailure) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionButton(
              label: actionButtonLabel,
              onPressed: () {
                context.read<TasksCubit>().sendResult();
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class ProcessContent extends StatelessWidget {
  const ProcessContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ProcessMessage(),
            const SizedBox(height: 8.0),
            Text(
              '${state.progresValue.toStringAsFixed(0)} %',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            RadialProgressIndicator(value: state.progresValue / 100),
          ],
        );
      },
    );
  }
}

class ProcessMessage extends StatelessWidget {
  const ProcessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'All calculations have finished, you can send your results to the server',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0),
    );
  }
}
