import 'package:flutter/material.dart';
import 'package:uneed/screen/unit_list.dart';
import 'package:uneed/screen/work_cost_tabs.dart';

class RouteScreen {
  final Icon icon;
  final String name;
  final Widget screen;

  const RouteScreen({
    required this.icon,
    required this.name,
    required this.screen
  });
}

List<RouteScreen> routes = [
  const RouteScreen(
    icon: Icon(Icons.attach_money),
    name: 'Hasil Bersih',
    screen: WorkCostTabs()
  ),
  const RouteScreen(
    icon: Icon(Icons.construction),
    name: 'Units',
    screen: UnitListScreen()
  )
];