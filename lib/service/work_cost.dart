import 'package:sqflite/sqflite.dart';
import 'package:uneed/db.dart';

import '../model/work_cost.dart';

class WorkCostService {
  static Future<void> deleteWorkCost(int id) async {
    Database db = await DatabaseHelper.connect();

    await db.delete('work_cost', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> createWorkCost(WorkCost workCost) async {
    Database db = await DatabaseHelper.connect();

    await db.insert(
      'work_cost',
      workCost.toMap()
    );
  }

  static Future<List<WorkCost>> fetchWorkCost(String keyword) async {
    Database db = await DatabaseHelper.connect();

    final List<Map<String, Object?>> workCostMaps = await db.query('work_cost',
      where: 'title LIKE ?',
    whereArgs: ['%$keyword%'],
    orderBy: 'date DESC');

    return [
      for (final {
        'id': id as int,
        'title': title as String,
        'note': note as String,
        'date': date as String,
        'price_ton': priceTon as int,
        'capacity_ton': capacityTon as double,
        'fuel_price': fuelPrice as int,
        'fuel_liter': fuelLiter as int,
        'driver_percentage': driverPercentage as double
      } in workCostMaps)
        WorkCost(id: id, title: title, note: note, date: date, priceTon: priceTon, capacityTon: capacityTon, fuelPrice: fuelPrice, fuelLiter: fuelLiter, driverPercentage: driverPercentage)
    ];
  }
}