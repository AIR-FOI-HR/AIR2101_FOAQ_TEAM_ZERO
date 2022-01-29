import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/ticket_purchase/bill_details_screen.dart';
import '../../providers/bills.dart';
import './user_tickets_items.dart';

class MyReservations extends StatelessWidget {
  final userId = 'u1';

  @override
  Widget build(BuildContext context) {
    final billsProvData = Provider.of<Bills>(context).getBills(userId);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: constraints.maxHeight * 0.82,
          child: ListView.builder(
            itemCount: billsProvData.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              BillDetailsScreen.routeName,
                              arguments: billsProvData[i]);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: UserTicketsItems(billsProvData[i].id)),
                    if (i != billsProvData.length - 1)
                      Divider(
                        thickness: 3,
                        color: Theme.of(context).primaryColor,
                      )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
