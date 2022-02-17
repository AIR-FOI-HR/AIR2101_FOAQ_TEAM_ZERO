import 'package:flutter/material.dart';
import 'package:museum_app/models/bill.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/models/user_ticket.dart';
import 'package:museum_app/providers/bills.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';

import '../ticket_purchase/text_for_row.dart';

import '../../models/ticket.dart';

import '../../providers/user_tickets.dart';
import '../../providers/tickets.dart';

class TicketValidationRowData extends StatelessWidget {
  String billId;
  List<UserTicket> tickets;

  TicketValidationRowData(this.billId, this.tickets);

  @override
  Widget build(BuildContext context) {
    int numOfVisitors = 0;
    Bill bill = Provider.of<Bills>(context, listen: false).getBillsById(billId);
    for (var i = 0; i < tickets.length; i++) {
      if (tickets[i].billId == billId) {
        numOfVisitors += tickets[i].quantity;
      }
    }

    TextStyle textStyle = const TextStyle(fontSize: 16);
    User buyer =
        Provider.of<Users>(context, listen: false).findById(bill.userId);
    return Row(
      children: [
        TextForRow(
          textTheme: textStyle,
          expanded: 2,
          title: buyer.name + " " + buyer.surname,
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: numOfVisitors.toString(),
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: bill.museumTime.format(context),
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: '${bill.totalCost} €',
        ),
      ],
    );
  }
}
