class WorkCost {
  final int? id;
  final String? title;
  final String? note;
  final String date;
  final int priceTon;
  final double capacityTon;
  final int fuelPrice;
  final int fuelLiter;
  final double driverPercentage;

  double get loadPrice => priceTon * capacityTon;
  int get fuelCost => fuelLiter * fuelPrice;
  double get driverCost => ((loadPrice - fuelCost) * driverPercentage);
  double get profit => (loadPrice - fuelCost) - driverCost;

  WorkCost({
    this.id,
    this.title,
    this.note,
    required this.date,
    required this.priceTon,
    required this.capacityTon,
    required this.fuelPrice,
    required this.fuelLiter,
    required this.driverPercentage,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'price_ton': priceTon,
      'capacity_ton': capacityTon,
      'fuel_price': fuelPrice,
      'fuel_liter': fuelLiter,
      'driver_percentage': driverPercentage
    };
  }
}