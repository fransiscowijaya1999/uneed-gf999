import 'package:flutter/material.dart';
import 'package:uneed/service/work_cost.dart';

import '../model/work_cost.dart';

class WorkCostSaveDialog extends StatefulWidget {
  const WorkCostSaveDialog({
    super.key,
    required this.priceTon,
    required this.capacityTon,
    required this.fuelPrice,
    required this.fuelLiter,
    required this.driverPercentage
  });

  final int priceTon;
  final double capacityTon;
  final int fuelPrice;
  final int fuelLiter;
  final double driverPercentage;

  @override
  State<WorkCostSaveDialog> createState() => _WorkCostSaveDialogState();
}

InputDecoration decorationBuilder([String label = '']) {
  return InputDecoration(
      label: Text(label)
  );
}

class _WorkCostSaveDialogState extends State<WorkCostSaveDialog> {
  late TextEditingController titleController;
  late TextEditingController noteController;
  late TextEditingController dateController;

  Future<void> _saveWorkCost(String title, String note, String date) async {
    var workCost = WorkCost(
      title: title,
      note: note,
      date: date,
      priceTon: widget.priceTon,
      capacityTon: widget.capacityTon,
      fuelPrice: widget.fuelPrice,
      fuelLiter: widget.fuelLiter,
      driverPercentage: widget.driverPercentage,
    );

    await WorkCostService.createWorkCost(workCost);
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    noteController = TextEditingController();
    dateController = TextEditingController(text: DateTime.now().toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Simpan Hasil Bersih'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: decorationBuilder('Title'),
              controller: titleController,
            ),
            TextField(
              decoration: decorationBuilder('Note'),
              controller: noteController,
            ),
            TextField(
              decoration: decorationBuilder('Date'),
              controller: dateController,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Icon(Icons.check),
          onPressed: () async {
            await _saveWorkCost(titleController.text, noteController.text, dateController.text);

            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
        ),
        TextButton(
          child: const Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
  }
}
