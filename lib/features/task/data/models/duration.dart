class DurationModel {
  final int amount;
  final String unit;

  DurationModel({required this.amount, required this.unit});

  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      DurationModel(amount: json['amount'], unit: json['unit']);

  Map<String, dynamic> toJson() => {'unit': unit, 'amount': amount};

  int toMinute() {
    int multiplier = 1;
    if (unit.toLowerCase() == 'day') multiplier = 24 * 60;

    return amount * multiplier;
  }
}
