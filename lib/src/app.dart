import 'package:flutter/material.dart';
import 'package:myit/src/screens/home_screen/home_screen.dart';
import 'package:myit/src/shared/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyIt',
      home: const HomeScreen(),
      theme: AppThemes.themeLight,
    );
  }
}
