import 'package:flutter/material.dart';

import '../services/fund_service.dart';
import '../models/dashboard_data.dart';
import '../models/fund.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/fund_card.dart';
import '../theme/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FundService _fundService = FundService();
  bool isLoading = true;
  late DashboardData dashboardData;
  late List<Fund> displayedFunds;

  final List<String> riskOptions = ['Low', 'Moderate', 'High'];
  final List<String> sortOptions = ['Return (High→Low)', 'Return (Low→High)', 'Name (A→Z)'];
  List<String> selectedRisk = [];
  String selectedSort = 'Return (High→Low)';

  @override
  void initState() {
    super.initState();
    // Select all risks by default
    selectedRisk = List<String>.from(riskOptions);
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

  /// Filter and sort the displayed funds
  void applyFiltersAndSort() {
    List<Fund> funds = List.from(dashboardData.funds);

    // Multi-select filter by risk
    if (selectedRisk.length != riskOptions.length) {
      funds = funds.where((f) => selectedRisk.contains(f.risk)).toList();
    }

    // Sorting logic
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

  /// Show multi-select dialog for filtering risk, using StatefulBuilder for correct selection
  void _showMultiSelectDialog() {
    List<String> tempSelectedRisks = List<String>.from(selectedRisk);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppTheme.cardGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Filter by Risk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: riskOptions.map((risk) {
                    final isSelected = tempSelectedRisks.contains(risk);
                    return CheckboxListTile(
                      title: Text(risk, style: const TextStyle(color: Colors.white)),
                      value: isSelected,
                      activeColor: AppTheme.accentOrange,
                      checkColor: Colors.black,
                      onChanged: (checked) {
                        setStateDialog(() {
                          if (checked == true) {
                            tempSelectedRisks.add(risk);
                          } else {
                            tempSelectedRisks.remove(risk);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.black),
                  child: const Text('Apply'),
                  onPressed: () {
                    setState(() {
                      selectedRisk = tempSelectedRisks.isEmpty
                          ? List<String>.from(riskOptions)
                          : List<String>.from(tempSelectedRisks);
                    });
                    applyFiltersAndSort();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Show sort dialog
  void _showSelectionDialog({
    required String title,
    required List<String> options,
    required String currentValue,
    required Function(String) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((opt) {
                final isSelected = opt == currentValue;
                return ListTile(
                  title: Text(
                    opt,
                    style: TextStyle(
                      color: isSelected ? AppTheme.accentOrange : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedSort = opt;
                    });
                    applyFiltersAndSort();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  /// Animated, modern filter/sort bar with reset
  Widget _buildFilterSortBar() {
    bool filtersActive =
        selectedRisk.length != riskOptions.length || selectedSort != 'Return (High→Low)';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: 'Filter by Risk',
            child: IconButton(
              icon: const Icon(Icons.filter_alt_rounded, color: Colors.white),
              onPressed: () => _showMultiSelectDialog(),
            ),
          ),
          Tooltip(
            message: 'Sort',
            child: IconButton(
              icon: const Icon(Icons.sort_rounded, color: Colors.white),
              onPressed: () => _showSelectionDialog(
                title: 'Sort by',
                options: sortOptions,
                currentValue: selectedSort,
                onSelected: (val) {
                  setState(() {
                    selectedSort = val;
                  });
                  applyFiltersAndSort();
                },
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: filtersActive
                ? IconButton(
              key: const ValueKey('clear'),
              icon: const Icon(Icons.highlight_off_rounded, color: Colors.white70, size: 22),
              tooltip: 'Clear Filters & Sort',
              onPressed: () {
                setState(() {
                  selectedRisk = List<String>.from(riskOptions); // Reset filters
                  selectedSort = 'Return (High→Low)';           // Reset sort
                });
                applyFiltersAndSort();
              },
            )
                : const SizedBox(width: 0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppTheme.backgroundBlack,
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
