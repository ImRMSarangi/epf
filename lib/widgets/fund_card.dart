import 'package:flutter/material.dart';

import '../theme/theme.dart';

import '../models/fund.dart';

class FundCard extends StatelessWidget {
  final Fund fund;
  final bool isSelected;

  const FundCard({super.key, required this.fund, this.isSelected = false});

  String formatNumber(double value) {
    if (value >= 10000000) return '${(value / 10000000).toStringAsFixed(2)} C';
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(2)} L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)} K';
    return value.toStringAsFixed(0);
  }

  Color getReturnColor(String returnStr) {
    if (returnStr.startsWith('+')) {
      return Colors.greenAccent;  // green for positive
    }
    if (returnStr.startsWith('-')) {
      return Colors.redAccent;    // red for negative
    }
    return Colors.grey.shade400;
  }

  Icon getReturnIcon(String returnStr) {
    if (returnStr.startsWith('+')) {
      return Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 18);
    }
    if (returnStr.startsWith('-')) {
      return Icon(Icons.arrow_downward, color: Colors.redAccent, size: 18);
    }
    return Icon(Icons.remove, color: Colors.grey.shade500, size: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: isSelected
          ? AppTheme.accentBurntSienna.withOpacity(0.85)  // highlighted card bg
          : Colors.transparent,  // default transparent
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fund.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? Colors.white : AppTheme.accentBurntSienna,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallStat("Invested", "₹ ${formatNumber(fund.invested)}"),
                _buildSmallStat("Current", "₹ ${formatNumber(fund.current)}"),
                Row(
                  children: [
                    getReturnIcon(fund.returnRate),
                    const SizedBox(width: 4),
                    Text(
                      fund.returnRate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: getReturnColor(fund.returnRate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
