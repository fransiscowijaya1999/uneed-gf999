import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uneed/service/work_cost.dart';
import 'package:uneed/widget/work_cost_detail.dart';
import 'package:uneed/widget/work_cost_raw_detail.dart';

import '../model/work_cost.dart';

class WorkCostDetailScreen extends StatefulWidget {
  final WorkCost workCost;

  const WorkCostDetailScreen({super.key, required this.workCost});

  @override
  State<WorkCostDetailScreen> createState() => _WorkCostDetailScreenState();
}

class _WorkCostDetailScreenState extends State<WorkCostDetailScreen> {
  late final WorkCost workCost;

  bool isDeleting = false;

  @override
  void initState() {
    super.initState();

    workCost = widget.workCost;
  }

  String formatAmount(double text) {
    return NumberFormat("#,##0.##").format(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workCost.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...workCost.note != null && workCost.note!.isNotEmpty ?
              [
                Row(
                  children: [
                    Expanded(
                      child: noteAppear(workCost.note!),
                    )
                  ],
                ),
                const SizedBox(height: 8,)
              ] :
              [const Center()],
            Row(
              children: [
                Expanded(
                  child: WorkCostRawDetailCard(
                      capacityTon: formatAmount(workCost.capacityTon),
                      priceTon: formatAmount(workCost.priceTon.toDouble()),
                      fuelLiter: formatAmount(workCost.fuelLiter.toDouble()),
                      fuelPrice: formatAmount(workCost.fuelPrice.toDouble()),
                      driverPercentage: (workCost.driverPercentage * 100).toString()
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: WorkCostDetailCard(
                      loadPrice: formatAmount(workCost.loadPrice),
                      fuelCost: formatAmount(workCost.fuelCost.toDouble()),
                      driverCost: formatAmount(workCost.driverCost),
                      profit: formatAmount(workCost.profit)
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                          onPressed: isDeleting ? null : () async {
                            setState(() {
                              isDeleting = true;
                            });

                            await WorkCostService.deleteWorkCost(workCost.id!);

                            if (!context.mounted) return;

                            Navigator.pop(
                              context,
                              'deleted'
                            );
                          },
                          child: const Icon(Icons.delete_forever)
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget noteAppear(String note) {
  return Card(
    color: Colors.yellow.shade500,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Note',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          Text(note)
        ],
      ),
    )
  );
}
