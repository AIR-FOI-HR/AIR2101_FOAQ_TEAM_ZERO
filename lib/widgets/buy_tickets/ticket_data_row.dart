import 'package:flutter/material.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:provider/provider.dart';

import '../../models/ticket.dart';
import '../../models/user_ticket.dart';

import '../../providers/bills.dart';
import '../../providers/user_tickets.dart';

class TicketDataRow extends StatefulWidget {
  Ticket ticketData;
  int counter;
  String newBillId;
  String museumId;
  int numberOfTickets;
  final Function setNumberOfTickets;

  TicketDataRow(this.ticketData, this.counter, this.newBillId, this.museumId,
      this.numberOfTickets, this.setNumberOfTickets);

  @override
  State<TicketDataRow> createState() => _TicketDataRowState();
}

class _TicketDataRowState extends State<TicketDataRow> {
  int _n = 0;
  TimeOfDay value = null;
  UserTicket newUserTicket =
      UserTicket(ticketId: null, billId: null, quantity: 0);

  void add() {
    setState(() {
      _n++;
      updateTheList(double.parse(widget.ticketData.cost));
      widget.setNumberOfTickets(widget.numberOfTickets + 1);
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) {
        _n--;
        updateTheList(double.parse(widget.ticketData.cost) * -1);
        widget.setNumberOfTickets(widget.numberOfTickets - 1);
      }
    });
  }

  void updateTheList(double price) {
    newUserTicket = UserTicket(
      ticketId: widget.ticketData.id,
      billId: widget.newBillId,
      quantity: _n,
    );
    Provider.of<UserTickets>(context, listen: false)
        .addUserTickets(newUserTicket);
    Provider.of<Bills>(context, listen: false)
        .updateBillTotalAmount(widget.newBillId, price);
  }

  @override
  Widget build(BuildContext context) {
    final billProv = Provider.of<Bills>(context);
    if (billProv.getSelectedTime() == null ||
        value != billProv.getSelectedTime()) {
      _n = 0;
      value = billProv.getSelectedTime();
    }
    final museum =
        Provider.of<Museums>(context, listen: false).getById(widget.museumId);
    final color = Theme.of(context);
    final textStyle = color.textTheme.headline4;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            widget.ticketData.name,
            style: textStyle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              widget.ticketData.cost,
              style: textStyle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: FloatingActionButton(
              heroTag: 'btn1-${widget.counter}',
              onPressed: minus,
              child: const Icon(Icons.remove, color: Colors.white),
              backgroundColor: color.primaryColorLight,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              '$_n',
              style: textStyle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: FloatingActionButton(
              heroTag: 'btn2-${widget.counter}',
              onPressed: (billProv.getSelectedTime() != null) &&
                      (widget.numberOfTickets < museum.capacity)
                  ? add
                  : null,
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: (billProv.getSelectedTime() != null) &&
                      (widget.numberOfTickets < museum.capacity)
                  ? color.primaryColorLight
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
