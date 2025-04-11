import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/screens/todo_home_page.dart';

void main() {
  runApp(MyApp());
}

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          title: 'To-Do App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentTheme,
          home: TodoHomePage(),
        );
      },
    );
  }
}
