import 'package:flutter/material.dart';
import 'package:frontend/models/subscription.dart';

class UserSubscription extends StatelessWidget {
  final List<Subscription> subscriptions;

  UserSubscription({required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white54),
      columns: [
        DataColumn(label: Text('Subscription')),
        DataColumn(label: Text('price')),
      ],
      rows: subscriptions
          .map(
            ((element) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(element.name)),
                    DataCell(Text(element.price.toString())),
                  ],
                )),
          )
          .toList(),
    );
  }
}
