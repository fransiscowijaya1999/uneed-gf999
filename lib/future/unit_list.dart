import 'package:flutter/material.dart';
import 'package:uneed/widget/unit_list.dart';
import 'package:uneed/model/unit.dart';

class UnitListFuture extends StatelessWidget {
  final Future<List<Unit>> units;

  const UnitListFuture({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: units,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return UnitList(units: snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
            child: ElevatedButton(onPressed: () {}, child: const Icon(Icons.refresh))
          );
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}