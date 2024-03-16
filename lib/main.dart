import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/home/presentation/views/splash_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  ProjectLocalStorage().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ProjectColors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ProjectColors.red, width: 2)),
        ),
      ),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: ProjectColors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: ProjectColors.black,
          )),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
