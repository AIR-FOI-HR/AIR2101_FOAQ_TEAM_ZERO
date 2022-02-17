// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:museum_app/models/user_ticket.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/tickets.dart';
import 'package:museum_app/providers/user_tickets.dart';
import 'package:provider/provider.dart';

import '../../providers/bills.dart';

class WorkTimeItem extends StatefulWidget {
  var workTime;
  var museumId;
  DateTime selectedDate;
  final Function setNumberOfTickets;

  WorkTimeItem(
      this.workTime, this.museumId, this.selectedDate, this.setNumberOfTickets);

  @override
  _WorkTimeItemState createState() => _WorkTimeItemState();
}

class _WorkTimeItemState extends State<WorkTimeItem> {
  @override
  Widget build(BuildContext context) {
    String openingSection = widget.workTime['openingTime'].format(context);
    String closingSection = widget.workTime['closingTime'].format(context);

    //dobim sve karte koje nudi muzej
    final museumTicketTypes = Provider.of<Tickets>(context, listen: false)
        .getTickets(widget.museumId);
    //dobim muzej
    final museum =
        Provider.of<Museums>(context, listen: false).getById(widget.museumId);

    //dobim sve kupljene karte za taj muzej
    List<UserTicket> boughtTickets = [];
    for (var i = 0; i < museumTicketTypes.length; i++) {
      boughtTickets.addAll(Provider.of<UserTickets>(context, listen: false)
          .getAllTicketsForMuseumTicket(museumTicketTypes[i].id));
    }

    //dobim sve račune na odabrani datum i vrijeme
    final billsOnSelectedDate = Provider.of<Bills>(context, listen: false)
        .getBillsByDateAndTime(
            widget.selectedDate, widget.workTime['openingTime']);

    int numberOfBoughtTicketsForTimeAndDate = 0;

    for (var i = 0; i < billsOnSelectedDate.length; i++) {
      //iteriram se po ticketima i trazim one koji su na racunu i onda tima zbrojim sve vrijednosti
      numberOfBoughtTicketsForTimeAndDate = boughtTickets
          .where((el) => el.billId == billsOnSelectedDate[i].id)
          .fold(numberOfBoughtTicketsForTimeAndDate,
              (qty, ticket) => qty + ticket.quantity);
    }
    // print('Number of bought tickets: ' +
    //     numberOfBoughtTicketsForTimeAndDate.toString());

    final color = Theme.of(context);
    final billProv = Provider.of<Bills>(context);
    final billSelectedTime = billProv.getSelectedTime();
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: (billSelectedTime == null) ||
                  (billSelectedTime != widget.workTime['openingTime'])
              ? numberOfBoughtTicketsForTimeAndDate >= museum.capacity
                  ? Colors.grey
                  : Theme.of(context).primaryColorLight
              : Theme.of(context).highlightColor,
          boxShadow: kElevationToShadow[6],
        ),
        child: FlatButton(
          child: Text(
            '$openingSection - $closingSection',
            style: const TextStyle(
                color: Colors.white,
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.w900),
          ),
          onPressed: numberOfBoughtTicketsForTimeAndDate >= museum.capacity
              ? null
              : () {
                  setState(() {
                    billProv.setSelectedTime(widget.workTime['openingTime']);
                  });
                  widget
                      .setNumberOfTickets(numberOfBoughtTicketsForTimeAndDate);
                },
        ),
      ),
    );
  }
}
