import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uneed/formatter/decimal_separator.dart';
import 'package:uneed/store/work_cost_calculator.dart';
import 'package:uneed/widget/work_cost_detail.dart';
import 'package:uneed/widget/work_cost_save_dialog.dart';

InputDecoration decorationBuilder([String label = '']) {
  return InputDecoration(
      label: Text(label)
  );
}

class WorkCostCalculatorScreen extends StatefulWidget {
  const WorkCostCalculatorScreen({super.key});

  @override
  State<WorkCostCalculatorScreen> createState() => _WorkCostCalculatorScreenState();
}

Future<bool?> _showSaveDialog(BuildContext context, int priceTon, double capacityTon, int fuelPrice, int fuelLiter, double driverPercentage) async {
  return await showDialog<bool>(context: context, barrierDismissible: false, builder: (BuildContext context) {
    return WorkCostSaveDialog(
      priceTon: priceTon,
      capacityTon: capacityTon,
      fuelPrice: fuelPrice,
      fuelLiter: fuelLiter,
      driverPercentage: driverPercentage,
    );
  });
}

void onTapClearZero(TextEditingController controller) {
  if (double.tryParse(controller.text) == 0) {
    controller.text = '';
  }
}

String initialTextValue(double value) {
  return NumberFormat("#,##0.##").format(value);
}

class _WorkCostCalculatorScreenState extends State<WorkCostCalculatorScreen> {
  late TextEditingController pricePerTonController;
  late TextEditingController capacityTonController;
  late TextEditingController fuelLiterController;
  late TextEditingController fuelPriceController;
  late TextEditingController driverPercentageController;

  @override
  void initState() {
    final WorkCostCalculatorStore store = Provider.of<WorkCostCalculatorStore>(context, listen: false);

    super.initState();

    pricePerTonController = TextEditingController(text: initialTextValue(store.pricePerTon.toDouble()));
    capacityTonController = TextEditingController(text: initialTextValue(store.capacityTon));
    fuelLiterController = TextEditingController(text: initialTextValue(store.fuelLiter.toDouble()));
    fuelPriceController = TextEditingController(text: initialTextValue(store.fuelPrice.toDouble()));
    driverPercentageController = TextEditingController(text: initialTextValue(store.driverPercentage * 100));
  }

  @override
  void dispose() {
    pricePerTonController.dispose();
    capacityTonController.dispose();
    fuelLiterController.dispose();
    fuelPriceController.dispose();
    driverPercentageController.dispose();

    super.dispose();
  }

  void clearForm() {
    pricePerTonController.clear();
    capacityTonController.clear();
    fuelLiterController.clear();
    fuelPriceController.clear();
    driverPercentageController.clear();

    final WorkCostCalculatorStore store = Provider.of<WorkCostCalculatorStore>(context, listen: false);

    store.reset();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: decorationBuilder('Kapasitas Ton'),
                      controller: capacityTonController,
                      onChanged: context.read<WorkCostCalculatorStore>().onCapacityTonChange,
                      keyboardType: TextInputType.number,
                      onTap: () { onTapClearZero(capacityTonController); },
                      inputFormatters: [DecimalFormatter()],
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: TextField(
                      decoration: decorationBuilder('Harga per Ton'),
                      controller: pricePerTonController,
                      onChanged: context.read<WorkCostCalculatorStore>().onPricePerTonChange,
                      keyboardType: TextInputType.number,
                      onTap: () { onTapClearZero(pricePerTonController); },
                      inputFormatters: [DecimalFormatter()],

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: decorationBuilder('Liter BBM'),
                      keyboardType: TextInputType.number,
                      controller: fuelLiterController,
                      onChanged: context.read<WorkCostCalculatorStore>().onFuelLiterChange,
                      onTap: () { onTapClearZero(fuelLiterController); },
                      inputFormatters: [DecimalFormatter()],

                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: TextField(
                      decoration: decorationBuilder('Harga BBM per Liter'),
                      keyboardType: TextInputType.number,
                      controller: fuelPriceController,
                      onChanged: context.read<WorkCostCalculatorStore>().onFuelPriceChange,
                      onTap: () { onTapClearZero(fuelPriceController); },
                      inputFormatters: [DecimalFormatter()],

                    ),
                  )
                ],
              ),
              TextField(
                decoration: decorationBuilder('Persentase Supir (%)'),
                keyboardType: TextInputType.number,
                controller: driverPercentageController,
                onChanged: context.read<WorkCostCalculatorStore>().onDriverPercentageChange,
                onTap: () { onTapClearZero(driverPercentageController); }
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: WorkCostDetailCard(
                        loadPrice: context.watch<WorkCostCalculatorStore>().loadPriceFormatted,
                        fuelCost: context.watch<WorkCostCalculatorStore>().fuelCostFormatted,
                        driverCost: context.watch<WorkCostCalculatorStore>().driverCostFormatted,
                        profit: context.watch<WorkCostCalculatorStore>().profitFormatted,
                      )
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(onPressed: () async {
                        final saved = await _showSaveDialog(
                          context,
                          context.read<WorkCostCalculatorStore>().pricePerTon,
                          context.read<WorkCostCalculatorStore>().capacityTon,
                          context.read<WorkCostCalculatorStore>().fuelPrice,
                          context.read<WorkCostCalculatorStore>().fuelLiter,
                          context.read<WorkCostCalculatorStore>().driverPercentage,
                        );

                        if (saved != null && saved) {
                          clearForm();
                        }
                        }, child: const Icon(Icons.check))
                  ),
                  const SizedBox(width: 16,),
                  ElevatedButton(onPressed: clearForm, child: const Icon(Icons.cancel))
                ],
              )
            ],
          ),
        )
    );
  }
}