import 'package:flutter/material.dart';
import 'package:path_finder/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:path_finder/presentation/cubits/url_cubit/url_cubit.dart';
import 'package:path_finder/presentation/navigation/routes.dart';
import 'package:path_finder/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String title = 'Home screen';
  static const String textFieldTitle =
      'Set valid API base URL in order to continue';
  static const String actionButtonLabel = 'Start counting process';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(textFieldTitle),
          BlocBuilder<UrlCubit, UrlState>(
            builder: (context, state) {
              return Expanded(
                child: UrlTextField(
                  icon: const Icon(Icons.compare_arrows),
                  initValue: state.url,
                  onChanged: (value) =>
                      context.read<UrlCubit>().changedUrl(value),
                  errorMassage: state.message,
                  isValid: !state.urlStateStatus.isInvalid,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<UrlCubit, UrlState>(
        builder: (context, state) {
          if (state.urlStateStatus.isInvalid) {
            return const SizedBox();
          }
          return ActionButton(
            label: actionButtonLabel,
            onPressed: () {
              context.read<UrlCubit>().saveUrl();
              context.read<TasksCubit>().getTasks();
              Navigator.pushNamed(context, AppRoutes.procesScreen);
            },
          );
        },
      ),
    );
  }
}
