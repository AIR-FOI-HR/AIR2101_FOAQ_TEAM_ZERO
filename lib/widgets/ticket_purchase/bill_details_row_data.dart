import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'text_for_row.dart';

import '../../models/ticket.dart';

import '../../providers/user_tickets.dart';
import '../../providers/tickets.dart';

class BillDetailsRowData extends StatelessWidget {
  String ticketId;
  String billId;

  BillDetailsRowData(this.billId, this.ticketId);

  @override
  Widget build(BuildContext context) {
    Ticket ticketData = Provider.of<Tickets>(context).findById(ticketId);
    TextStyle textStyle = const TextStyle(fontSize: 16);
    int quantity = Provider.of<UserTickets>(context)
        .getSpecificUserTicket(billId, ticketId);
    double total = double.parse(ticketData.cost) * quantity;
    return Row(
      children: [
        TextForRow(
          textTheme: textStyle,
          expanded: 2,
          title: ticketData.name,
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: quantity.toString(),
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: '${ticketData.cost} €',
        ),
        TextForRow(
          textTheme: textStyle,
          expanded: 1,
          title: '${total.toStringAsFixed(2)} €',
        ),
      ],
    );
  }
}
