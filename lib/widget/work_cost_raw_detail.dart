import 'package:flutter/material.dart';

class WorkCostRawDetailCard extends StatelessWidget {
  final String capacityTon;
  final String priceTon;
  final String fuelLiter;
  final String fuelPrice;
  final String driverPercentage;

  const WorkCostRawDetailCard({
    super.key,
    required this.capacityTon,
    required this.priceTon,
    required this.fuelLiter,
    required this.fuelPrice,
    required this.driverPercentage
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
                  text: 'Kapasitas Ton: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: '$capacityTon Ton', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))
                  ]
              )),
              RichText(text: TextSpan(
                  text: 'Harga Ton: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Rp$priceTon', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))
                  ]
              )),
              RichText(text: TextSpan(
                  text: 'Liter BBM: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: '$fuelLiter L', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                  ]
              )),
              RichText(text: TextSpan(
                  text: 'Harga BBM: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Rp$fuelPrice', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                  ]
              )),
              const SizedBox(height: 2,),
              RichText(text: TextSpan(
                  text: 'Persentase Supir: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: '$driverPercentage%',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)
                    )
                  ]
              ))
            ],
          )
      ),
    );
  }
}