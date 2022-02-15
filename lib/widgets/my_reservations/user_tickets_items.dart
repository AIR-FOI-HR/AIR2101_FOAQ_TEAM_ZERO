import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/museums.dart';
import '../../providers/user_tickets.dart';
import '../../providers/tickets.dart';
import '../../providers/bills.dart';

import '../../models/bill.dart';
import '../../models/museum.dart';

import './elevated_button_my_reservation.dart';

class UserTicketsItems extends StatelessWidget {
  final String billId;

  UserTicketsItems(this.billId);

  @override
  Widget build(BuildContext context) {
    final billProv = Provider.of<Bills>(context, listen: false);
    final userTicketProv = Provider.of<UserTickets>(context, listen: false);
    final Bill billData = billProv.getBillsById(billId);
    final String userTicketsId =
        userTicketProv.getUserTicketIdByBillId(billData.id);
    final String museumId = Provider.of<Tickets>(context, listen: false)
        .getMuseumIdByTicketId(userTicketsId);
    final Museum museumData =
        Provider.of<Museums>(context, listen: false).getById(museumId);
    final textTheme = Theme.of(context).textTheme.headline4;
    final DateFormat date = DateFormat('dd.MM.yyyy.');
    final String buttonData = billProv.getButtonDataFromDate(billData);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              museumData.name,
              style: textTheme,
            ),
            Text(
              date.format(billData.date),
              style: textTheme,
            ),
          ],
        ),
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    museumData.address,
                    style: textTheme,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      billData.museumTime.format(context),
                      style: textTheme,
                    ),
                    Text(
                      billData.isCanceled
                          ? 'Cancelled'
                          : billProv.getDataFromDate(billData.date),
                      style: textTheme,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${billData.totalCost} €',
                      style: textTheme,
                    ),
                    ElevatedButtonMyReservation(buttonData, () async {
                      if (buttonData == 'Delete') {
                        userTicketProv.deleteUserTicket(billData.id);
                        billProv.deleteBill(billData.id);
                        await DBCaller.deleteBill(billData.id);
                        await DBCaller.deleteUserTicket(billData.id);
                      } else {
                        billProv.calcelBill(billData.id);
                        billData.isCanceled = true;
                        await DBCaller.updateBill(billData);
                      }
                    })
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
