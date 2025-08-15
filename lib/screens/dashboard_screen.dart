import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For professional font in AppBar
import '../services/fund_service.dart';
import '../models/dashboard_data.dart';
import '../models/fund.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/fund_card.dart';
import '../theme/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FundService _fundService = FundService();
  bool isLoading = true;
  late DashboardData dashboardData;
  late List<Fund> displayedFunds;

  String selectedRisk = 'All';
  String selectedSort = 'Return (High→Low)';

  final riskOptions = ['All', 'Low', 'Moderate', 'High'];
  final sortOptions = ['Return (High→Low)', 'Return (Low→High)', 'Name (A→Z)'];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await _fundService.fetchDashboardData();
    setState(() {
      dashboardData = data;
      displayedFunds = List.from(dashboardData.funds);
      isLoading = false;
    });
  }

  void applyFiltersAndSort() {
    List<Fund> funds = List.from(dashboardData.funds);

    // Filter funds by risk
    if (selectedRisk != 'All') {
      funds = funds.where((f) => f.risk.toLowerCase() == selectedRisk.toLowerCase()).toList();
    }

    // Sort funds by selected criteria
    if (selectedSort == 'Return (High→Low)') {
      funds.sort((a, b) => _parseReturn(b.returnRate).compareTo(_parseReturn(a.returnRate)));
    } else if (selectedSort == 'Return (Low→High)') {
      funds.sort((a, b) => _parseReturn(a.returnRate).compareTo(_parseReturn(b.returnRate)));
    } else if (selectedSort == 'Name (A→Z)') {
      funds.sort((a, b) => a.name.compareTo(b.name));
    }

    setState(() {
      displayedFunds = funds;
    });
  }

  double _parseReturn(String returnStr) {
    return double.tryParse(returnStr.replaceAll('+', '').replaceAll('%', '')) ?? 0.0;
  }

  void _showSelectionModal({
    required String title,
    required List<String> options,
    required String currentValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1F2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...options.map((opt) {
                  final isSelected = opt == currentValue;
                  return ListTile(
                    title: Text(opt,
                        style: TextStyle(
                          color: isSelected ? AppTheme.accentBurntSienna : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        )),
                    onTap: () {
                      onSelected(opt);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSortBar() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade600),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _showSelectionModal(
                title: 'Filter by Risk',
                options: riskOptions,
                currentValue: selectedRisk,
                onSelected: (val) {
                  selectedRisk = val;
                  applyFiltersAndSort();
                },
              );
            },
            icon: const Icon(Icons.filter_list, size: 18),
            label: Text(selectedRisk),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade600),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _showSelectionModal(
                title: 'Sort by',
                options: sortOptions,
                currentValue: selectedSort,
                onSelected: (val) {
                  selectedSort = val;
                  applyFiltersAndSort();
                },
              );
            },
            icon: const Icon(Icons.sort, size: 18),
            label: Text(selectedSort),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make scaffold background transparent
      appBar: AppBar(
        title: Text(
          'My ePF',
          style: GoogleFonts.gabarito(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1D1F33)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        PortfolioSummaryCard(data: dashboardData),
                        const SizedBox(height: 16),
                        _buildFilterSortBar(),
                        const SizedBox(height: 16),
                        ...displayedFunds.map(
                              (fund) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: FundCard(fund: fund),
                          ),
                        ),
                        // Optional: add Spacer() here if you want content centered when few items
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
