import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uneed/screen/work_cost_detail.dart';
import 'package:uneed/service/work_cost.dart';

import '../model/work_cost.dart';

class WorkCostListScreen extends StatefulWidget {
  const WorkCostListScreen({super.key});

  @override
  State<WorkCostListScreen> createState() => _WorkCostListScreenState();
}

class _WorkCostListScreenState extends State<WorkCostListScreen> {
  String searchText = '';
  late TextEditingController searchController;
  late Future<List<WorkCost>> workCostFuture;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
    workCostFuture = WorkCostService.fetchWorkCost(searchController.text);
  }

  void _handleSearchChange(String text) {
    setState(() {
      searchText = text;
      workCostFuture = WorkCostService.fetchWorkCost(text);
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child:TextField(
                onChanged: _handleSearchChange,
              ),
            ),
            Expanded(
              child: FutureBuilder(future: workCostFuture, builder: (context, AsyncSnapshot<List<WorkCost>> snapshot) {
                if (snapshot.hasData) {
                  final workCosts = snapshot.data!;

                  if (workCosts.isEmpty) {
                    return const Center(child: Text('Tidak ditemukan data.'));
                  } else {
                      return ListView.builder(
                          itemCount: workCosts.length,
                          itemBuilder: (context, index) {
                            return WorkCostTile(
                              workCost: workCosts[index],
                              deleted: () {
                                setState(() {
                                  workCostFuture = WorkCostService.fetchWorkCost(searchText);
                                });
                              },
                            );
                          }
                      );
                  }
                } else if (snapshot.hasError) {
                  return const Center(child: Text('An error has occured when fetching data'));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
            )
          ],
        )
      );
  }
}

class WorkCostTile extends StatelessWidget {
  final WorkCost workCost;
  final Function deleted;

  const WorkCostTile({
    super.key,
    required this.workCost,
    required this.deleted
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workCost.title ?? ''),
      subtitle: RichText(text: TextSpan(
        text: formatToSimple(workCost.date),
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold
        ),
        children: [
          const TextSpan(
            text: ' - ',
            style: TextStyle(
              color: Colors.black
            )
          ),
          TextSpan(
            text: 'Rp${NumberFormat("#,##0.##").format(workCost.profit).toString()}',
            style: const TextStyle(color: Colors.green)         
          )
        ]
      )),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkCostDetailScreen(workCost: workCost))
        );

        if (!context.mounted) return;

        if (result == 'deleted') {
          deleted();
        }
      },
    );
  }
}

String formatToSimple(String date) {
  DateFormat format = DateFormat('yyyy-MM-dd');
  DateTime dateTime = format.parse(date);

  return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
}