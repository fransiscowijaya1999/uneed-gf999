import 'package:flutter/material.dart';
import 'package:uneed/widget/unit_list.dart';

class UnitListScreen extends StatefulWidget {
  const UnitListScreen({super.key});

  @override
  State<UnitListScreen> createState() => _UnitListScreenState();
}

class _UnitListScreenState extends State<UnitListScreen> {
  late TextEditingController query;

  @override
  void initState() {
    super.initState();

    query = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Units'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: query,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search unit'
              ),
            )
          ),
          const Expanded(child: UnitList(units: []))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Create new Unit',
        child: const Icon(Icons.add),
      ),
    );
  }
}