import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../screens/museum_detail_screen.dart';

import '../../widgets/app_bar.dart';

import '../../providers/user_tickets.dart';
import '../../providers/tickets.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';

import '../../models/user.dart';
import '../../models/museum.dart';
import '../../models/bill.dart';

import '../../widgets/ticket_purchase/bill_details_row_data.dart';
import '../../widgets/ticket_purchase/text_for_row.dart';

class BillDetailsScreen extends StatelessWidget {
  static const routeName = "/billDetails";
  @override
  Widget build(BuildContext context) {
    Bill billData = ModalRoute.of(context).settings.arguments as Bill;
    User appUser = Provider.of<Users>(context, listen: false).getUser();

    final color = Theme.of(context);
    final textTheme = color.textTheme.headline4;
    final appBarProperty =
        appBar('Bill details', context, color.primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);
    final DateFormat date = DateFormat('dd.MM.yyyy.');

    final userTicketProv = Provider.of<UserTickets>(context, listen: false);
    final ticketsData = userTicketProv.getUserTicket(billData.id);
    final ticketId = userTicketProv.getUserTicketIdByBillId(billData.id);

    final String museumId = Provider.of<Tickets>(context, listen: false)
        .getMuseumIdByTicketId(ticketId);
    final Museum museumData =
        Provider.of<Museums>(context, listen: false).getById(museumId);
    return Scaffold(
      appBar: appBarProperty,
      body: Container(
        margin: const EdgeInsets.all(10),
        height: (mediaQuery.size.height -
            appBarProperty.preferredSize.height -
            mediaQuery.padding.top),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: GridTile(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        MuseumDetailScreen.routeName,
                        arguments: museumId),
                    child: Image.network(
                      museumData.imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  header: GridTileBar(
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        museumData.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            museumData.address,
                            style: textTheme,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            date.format(billData.date),
                            style: textTheme,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        billData.museumTime.format(context),
                        style: color.textTheme.headline5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextForRow(
                          textTheme: textTheme,
                          expanded: 2,
                          title: 'Ticket type',
                        ),
                        TextForRow(
                            textTheme: textTheme, expanded: 1, title: 'Qty'),
                        TextForRow(
                            textTheme: textTheme, expanded: 1, title: 'Price'),
                        TextForRow(
                            textTheme: textTheme, expanded: 1, title: 'Total'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: ticketsData.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            BillDetailsRowData(
                                billData.id, ticketsData[i].ticketId),
                            const Divider(thickness: 1),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appUser.name,
                                style: textTheme,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                appUser.surname,
                                style: textTheme,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Time of purchase if we dont forgot to add hehehe',
                                maxLines: 2,
                                style: textTheme,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                'Paid: ${billData.totalCost} €',
                                style: color.textTheme.headline5,
                              ),
                              Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png'),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
