import 'package:flutter/material.dart';
import '../theme/theme.dart';

class HoldingsScreen extends StatelessWidget {
  const HoldingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundBlack,
      child: const Center(
        child: Text("Holdings", style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}
