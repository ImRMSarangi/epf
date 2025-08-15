import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundBlack,
      child: const Center(
        child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}
