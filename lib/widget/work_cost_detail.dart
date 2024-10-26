import 'package:flutter/material.dart';

class WorkCostDetailCard extends StatelessWidget {
  final String loadPrice;
  final String fuelCost;
  final String driverCost;
  final String profit;

  const WorkCostDetailCard({
    super.key,
    required this.loadPrice,
    required this.fuelCost,
    required this.driverCost,
    required this.profit
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(text: TextSpan(
                  text: 'Harga Angkutan: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Rp$loadPrice', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))
                  ]
              )),
              RichText(text: TextSpan(
                  text: 'Ongkos BBM: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Rp$fuelCost', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                  ]
              )),
              RichText(text: TextSpan(
                  text: 'Ongkos Supir: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Rp$driverCost', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                  ]
              )),
              const SizedBox(height: 2,),
              RichText(text: TextSpan(
                  text: 'Hasil Bersih: ',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Rp$profit',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
                    )
                  ]
              ))
            ],
          )
      ),
    );
  }
}