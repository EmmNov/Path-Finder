import 'package:flutter/material.dart';
import 'package:path_finder/presentation/screens/home_screen.dart';
import 'package:path_finder/presentation/screens/preview_screen.dart';
import 'package:path_finder/presentation/screens/process_screen.dart';
import 'package:path_finder/presentation/screens/result_list_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String procesScreen = '/proces_screen';
  static const String resultListScreen = '/result_list_screen';
  static const String previewScreen = '/result_list_screen/preview_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case procesScreen:
        return MaterialPageRoute(builder: (_) => const ProcesScreen());
      case resultListScreen:
        return MaterialPageRoute(builder: (_) => const ResultListScreen());
      case previewScreen:
        return MaterialPageRoute(
            builder: (_) => const PreviewScreen(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      );
    });
  }
}
