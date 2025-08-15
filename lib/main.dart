import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/main_home.dart'; // New main nav file

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My MF App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainHome(), // <-- show bottom nav
    );
  }
}
