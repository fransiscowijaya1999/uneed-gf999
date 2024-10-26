import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

String formatAmount(double text) {
  return NumberFormat("#,##0.##").format(text);
}

class WorkCostCalculatorStore with ChangeNotifier {
  int _pricePerTon = 0;
  double _capacityTon = 0;
  int _fuelPrice = 0;
  int _fuelLiter = 0;
  double _driverPercentage = 0;

  double get loadPrice => _pricePerTon * _capacityTon;
  int get fuelCost => _fuelLiter * _fuelPrice;
  double get driverCost => ((loadPrice - fuelCost) * _driverPercentage);
  double get profit => (loadPrice - fuelCost) - driverCost;

  int get pricePerTon => _pricePerTon;
  double get capacityTon => _capacityTon;
  int get fuelPrice => _fuelPrice;
  int get fuelLiter => _fuelLiter;
  double get driverPercentage => _driverPercentage;

  String get loadPriceFormatted => formatAmount(loadPrice.toDouble());
  String get fuelCostFormatted => formatAmount(fuelCost.toDouble());
  String get driverCostFormatted => formatAmount(driverCost.toDouble());
  String get profitFormatted => formatAmount(profit.toDouble());

  void reset() {
    setPricePerTon(0);
    setCapacityTon(0);
    setFuelPrice(0);
    setFuelLiter(0);
    setDriverPercentage(0);
  }

  void onPricePerTonChange(String text) {
    int parsed = text.isEmpty ? 0 : NumberFormat().parse(text.replaceAll(',', '')).toInt();

    setPricePerTon(parsed);
  }

  void onCapacityTonChange(String text) {
    double parsed = text.isEmpty ? 0 : NumberFormat().parse(text.replaceAll(',', '')).toDouble();

    setCapacityTon(parsed);
  }

  void onFuelPriceChange(String text) {
    int parsed = text.isEmpty ? 0 : NumberFormat().parse(text.replaceAll(',', '')).toInt();

    setFuelPrice(parsed);
  }

  void onFuelLiterChange(String text) {
    int parsed = text.isEmpty ? 0 : NumberFormat().parse(text.replaceAll(',', '')).toInt();

    setFuelLiter(parsed);
  }

  void onDriverPercentageChange(String text) {
    int parsed = text.isEmpty ? 0 : NumberFormat().parse(text.replaceAll(',', '')).toInt();

    setDriverPercentage(parsed / 100);
  }

  void setPricePerTon(int value) {
    _pricePerTon = value;

    notifyListeners();
  }

  void setCapacityTon(double value) {
    _capacityTon = value;

    notifyListeners();
  }

  void setFuelPrice(int value) {
    _fuelPrice = value;
    notifyListeners();
  }

  void setFuelLiter(int value) {
    _fuelLiter = value;
    notifyListeners();
  }

  void setDriverPercentage(double value) {
    _driverPercentage = value;
    notifyListeners();
  }
}