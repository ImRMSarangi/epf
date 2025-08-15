import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/dashboard_data.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final DashboardData data;
  const PortfolioSummaryCard({super.key, required this.data});

  String formatNumber(double value) {
    if (value >= 10000000) return '${(value / 10000000).toStringAsFixed(2)} C';
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(2)} L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)} K';
    return value.toStringAsFixed(0);
  }

  Color getReturnColor(String returnStr) {
    if (returnStr.startsWith('+')) return AppTheme.accentBurntSienna;
    if (returnStr.startsWith('-')) return AppTheme.accentBurntSienna;
    return Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade700, Colors.indigo.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Portfolio",
                style: TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat("Invested", formatNumber(data.totalInvested), Colors.white),
                _buildStat("Current", formatNumber(data.totalCurrent), Colors.white),
                _buildStat("Return", data.totalReturn, getReturnColor(data.totalReturn)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
