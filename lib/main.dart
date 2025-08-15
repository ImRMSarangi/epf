import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MutualFundApp());
}

class MutualFundApp extends StatelessWidget {
  const MutualFundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Fund Dashboard',
      debugShowCheckedModeBanner: false,

      // 🔹 Currently only Dark theme (Brown & Maroon)
      theme: AppTheme.darkTheme,

      // If you later add light theme in AppTheme:
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system, // Auto-switch based on OS setting

      home: const DashboardScreen(),
    );
  }
}
