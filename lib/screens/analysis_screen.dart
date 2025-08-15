import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundBlack,
      child: const Center(
        child: Text("Analysis", style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}
