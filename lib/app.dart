import 'package:flutter/material.dart';
import 'package:pepper_cloud_test/core/theme/app_theme.dart';
import 'features/todo/presentation/pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().appTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
