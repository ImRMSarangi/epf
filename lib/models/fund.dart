class Fund {
  final String name;
  final double invested;
  final double current;
  final String risk;
  final String returnRate;

  Fund({
    required this.name,
    required this.invested,
    required this.current,
    required this.risk,
    required this.returnRate,
  });

  /// Factory constructor to create a Fund from raw JSON and auto-calculate returnRate
  factory Fund.fromJson(Map<String, dynamic> json) {
    final invested = (json['invested'] as num).toDouble();
    final current = (json['current'] as num).toDouble();
    final pct = ((current - invested) / invested) * 100;
    return Fund(
      name: json['name'],
      invested: invested,
      current: current,
      risk: json['risk'],
      returnRate: "${pct >= 0 ? '+' : ''}${pct.toStringAsFixed(1)}%",
    );
  }

  /// Convert Fund object to JSON (useful for local storage or API POST)
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "invested": invested,
      "current": current,
      "risk": risk,
      "returnRate": returnRate,
    };
  }
}
