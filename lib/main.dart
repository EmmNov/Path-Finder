import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/data/repository/task_reposotory.dart';
import 'package:path_finder/data/repository/url_repository.dart';
import 'package:path_finder/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:path_finder/presentation/cubits/url_cubit/url_cubit.dart';
import 'package:path_finder/presentation/theme/app_theme.dart';

import 'presentation/navigation/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final urlRepo = UrlRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksCubit(TaskReposotoryImpl(urlRepo)),
        ),
        BlocProvider(
          create: (context) => UrlCubit(urlRepo)..getUrl(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
