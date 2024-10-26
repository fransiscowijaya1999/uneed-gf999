import 'package:flutter/material.dart';
import 'package:uneed/routes.dart';

class MainNavigationBar extends StatelessWidget {
  final List<RouteScreen> routes;
  final int selectedIndex;
  final Function(int) onSelectedCallback;

  const MainNavigationBar({super.key, required this.routes, required this.selectedIndex, required this.onSelectedCallback});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: destinationBuilder(routes),
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelectedCallback,
    );
  }
}

List<NavigationDestination> destinationBuilder(List<RouteScreen> routes) {
  List<NavigationDestination> destinations = [];
  
  for (var route in routes) {
    destinations.add(
      NavigationDestination(icon: route.icon, label: route.name)
    );
  }

  return destinations;
}