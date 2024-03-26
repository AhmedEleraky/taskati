import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/themes/themes.dart';
import 'package:taskati/features/data/task_model.dart';
import 'package:taskati/features/splash_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('task');
  await Hive.openBox<bool>('mode');
  ProjectLocalStorage().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('user').listenable(),
        builder: (context, box, child) {
          bool darkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp(
            theme: AppThemes.appLightTheme,
            darkTheme: AppThemes.appDarkTheme,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          );
        });
  }
}
