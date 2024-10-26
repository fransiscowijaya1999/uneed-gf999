import 'package:flutter/material.dart';
import 'package:uneed/model/unit.dart';

class UnitList extends StatelessWidget {
  final List<Unit> units;
  const UnitList({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: units.length,
      itemBuilder: (context, index) {
        return UnitTile(unit: units[index]);
      },
    );
  }
}

class UnitTile extends StatelessWidget {
  final Unit unit;
  const UnitTile({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(unit.name),
    );
  }
}