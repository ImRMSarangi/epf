import 'fund.dart';

class DashboardData {
  final double totalInvested;
  final double totalCurrent;
  final String totalReturn;
  final List<Fund> funds;

  DashboardData({
    required this.totalInvested,
    required this.totalCurrent,
    required this.totalReturn,
    required this.funds,
  });

  factory DashboardData.fromFunds(List<Fund> funds) {
    final totalInvested = funds.fold<double>(0, (sum, f) => sum + f.invested);
    final totalCurrent = funds.fold<double>(0, (sum, f) => sum + f.current);
    final totalPct = ((totalCurrent - totalInvested) / totalInvested) * 100;

    return DashboardData(
      totalInvested: totalInvested,
      totalCurrent: totalCurrent,
      totalReturn: "${totalPct >= 0 ? '+' : ''}${totalPct.toStringAsFixed(1)}%",
      funds: funds,
    );
  }
}
