import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uneed/routes.dart';
import 'package:uneed/store/work_cost_calculator.dart';
import 'package:uneed/widget/main_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final List<RouteScreen> routes;
  final int defaultRouteIndex;

  const HomePage({super.key, required this.routes, this.defaultRouteIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentRouteIndex;

  @override
  void initState() {
    super.initState();

    currentRouteIndex = widget.defaultRouteIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MainNavigationBar(
          routes: widget.routes,
          selectedIndex: currentRouteIndex,
          onSelectedCallback: (int index) {
            setState(() {
              currentRouteIndex = index;
            });
          }
      ),
      body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => WorkCostCalculatorStore())
          ],
        child: widget.routes[currentRouteIndex].screen,
      )
    );
  }
}