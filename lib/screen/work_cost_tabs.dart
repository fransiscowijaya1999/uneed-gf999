import 'package:flutter/material.dart';
import 'package:uneed/screen/work_cost_calculator.dart';
import 'package:uneed/screen/work_cost_list.dart';

class WorkCostTabs extends StatelessWidget {
  const WorkCostTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hasil Bersih'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.calculate)),
              Tab(icon: Icon(Icons.list))
            ])
          ),
          body: const TabBarView(children: [
            WorkCostCalculatorScreen(),
            WorkCostListScreen()
          ]),
        ),
    );
  }
}