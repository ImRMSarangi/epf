import '../models/fund.dart';
import '../models/dashboard_data.dart';

class FundService {
  /// Simulates fetching dashboard data from an API
  Future<DashboardData> fetchDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate API delay

    // Raw mock JSON-like data from "API"
    final rawFunds = [
      {
        "name": "ABC Large Cap",
        "invested": 250000.0,
        "current": 270000.0,
        "risk": "High",
      },
      {
        "name": "DEF Mid Cap",
        "invested": 180000.0,
        "current": 203000.0,
        "risk": "High",
      },
      {
        "name": "GHI Small Cap",
        "invested": 100000.0,
        "current": 93000.0,
        "risk": "High",
      },
      {
        "name": "JKL Flexi Cap",
        "invested": 140000.0,
        "current": 153300.0,
        "risk": "Moderate",
      },
      {
        "name": "MNO Multi Cap",
        "invested": 152000.0,
        "current": 160000.0,
        "risk": "Moderate",
      },
      {
        "name": "PQR Arbitrage Fund",
        "invested": 93000.0,
        "current": 101400.0,
        "risk": "Moderate",
      },
      {
        "name": "STU Liquid Fund",
        "invested": 140000.0,
        "current": 143300.0,
        "risk": "Low",
      },
    ];

    // Convert raw list to List<Fund> using our model's factory
    final List<Fund> funds = rawFunds.map((json) => Fund.fromJson(json)).toList();

    // Build and return DashboardData from funds
    return DashboardData.fromFunds(funds);
  }
}
