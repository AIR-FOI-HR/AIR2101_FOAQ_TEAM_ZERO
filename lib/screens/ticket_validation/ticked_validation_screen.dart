import 'dart:io';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/bill.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/models/user_ticket.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:museum_app/providers/bills.dart';
import 'package:museum_app/providers/categories.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/tickets.dart';
import 'package:museum_app/providers/user_tickets.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/providers/work_times.dart';
import 'package:museum_app/widgets/app_bar.dart';
import 'package:museum_app/widgets/main_menu_drawer.dart';
import 'package:museum_app/widgets/ticket_configuration/elevated_button_settings.dart';
import 'package:museum_app/widgets/ticket_purchase/bill_details_row_data.dart';
import 'package:museum_app/widgets/ticket_purchase/text_for_row.dart';
import 'package:museum_app/widgets/ticket_validation/ticket_validation_row_data.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TicketValidationScreen extends StatefulWidget {
  static const routeName = '/ticketValidation';
  @override
  _TicketValidationScreenState createState() => _TicketValidationScreenState();
}

class _TicketValidationScreenState extends State<TicketValidationScreen> {
  bool _isFetched = false;
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode result;
  bool scan = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    User appUser = Provider.of<Users>(context).getUser();

    Future<void> _refreshAllData() async {
      await Provider.of<Museums>(context, listen: false).fetchMuseums();
      await Provider.of<Artworks>(context, listen: false).fetchArtworks();
      await Provider.of<Tickets>(context, listen: false).fetchTickets();
      await Provider.of<Categories>(context, listen: false).fetchCategories();
      await Provider.of<WorkTimes>(context, listen: false).fetchWorkTimes("");
      await Provider.of<UserTickets>(context, listen: false).fetchUserTickets();
      await Provider.of<Bills>(context, listen: false).fetchBills();
      await Provider.of<Users>(context, listen: false).fetchUsers();
      await Future.delayed(Duration(milliseconds: 700));
      _isFetched = true;
    }

    final museumTicketTypes = Provider.of<Tickets>(context, listen: false)
        .getTickets(appUser.museumId);

    //dobim sve kupljene karte za taj muzej
    List<UserTicket> boughtTickets = [];
    for (var i = 0; i < museumTicketTypes.length; i++) {
      boughtTickets.addAll(Provider.of<UserTickets>(context, listen: false)
          .getAllTicketsForMuseumTicket(museumTicketTypes[i].id));
    }

    List<String> billIdsWithDuplicates = [];

    for (var i = 0; i < boughtTickets.length; i++) {
      billIdsWithDuplicates.add(boughtTickets[i].billId);
    }
    List<String> billIds = billIdsWithDuplicates.toSet().toList();

    //dobim sve ra??une na odabrani datum i vrijeme
    final billsOnSelectedDate =
        Provider.of<Bills>(context, listen: false).getBillsForToday();
    print("Racuuuuniiiii " + billsOnSelectedDate.length.toString());

    List<Bill> billsTodayForMuseum = [];
    for (var i = 0; i < billIds.length; i++) {
      Bill bill = null;
      bill = billsOnSelectedDate.firstWhereOrNull(
          (bill) => bill.id == billIds[i] && bill.isUsed == true);
      if (bill != null) {
        billsTodayForMuseum.add(bill);
      }
    }
    print('Racuni od muzeja ' + billsTodayForMuseum.length.toString());
    final appBarProperty =
        appBar('Validate tickets', context, color.primaryColor, appUser);
    final textTheme = color.textTheme.headline4;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshAllData,
        child: FutureBuilder(
          future: _isFetched ? null : _refreshAllData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                _isFetched) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: scan
                    ? buildQrView(context)
                    : result != null
                        ? showBillInfo(
                            context, result.code, appBarProperty, appUser)
                        : showVisitorsScreen(context, mediaQuery, textTheme,
                            billsTodayForMuseum, boughtTickets),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).highlightColor,
        onPressed: () {
          setState(() {
            scan = !scan;
            result = null;
          });
        },
        child: const IconButton(
          icon: Icon(
            Icons.qr_code_scanner_sharp,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderColor: Colors.red,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
        onQRViewCreated: _onQRViewCreated,
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        this.controller.dispose();
        scan = !scan;
      });
    });
  }

  Widget showBillInfo(BuildContext context, String billId,
      AppBar appBarProperty, User appUser) {
    final mediaQuery = MediaQuery.of(context);
    final color = Theme.of(context);
    final DateFormat date = DateFormat('dd.MM.yyyy.');
    final textTheme = color.textTheme.headline4;
    var user, ticketsData, museumData;
    final userTicketProv = Provider.of<UserTickets>(context, listen: false);

    //get bill object
    final billData =
        Provider.of<Bills>(context, listen: false).getBillsById(billId);

    //if we find bill in firestore then we fetch all other objects
    if (billData != null) {
      user =
          Provider.of<Users>(context, listen: false).findById(billData.userId);

      ticketsData = userTicketProv.getUserTicket(billId);

      final ticketId = userTicketProv.getUserTicketIdByBillId(billId);

      final String museumId = Provider.of<Tickets>(context, listen: false)
          .getMuseumIdByTicketId(ticketId);

      museumData =
          Provider.of<Museums>(context, listen: false).getById(museumId);
      if (appUser.museumId != museumId) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Ticket is not for this museum',
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
              ),
            ),
          ),
        );
      }
    } else {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'Invalid QR code',
            style: TextStyle(
              fontSize: 22,
              color: Colors.red,
            ),
          ),
        ),
      );
    }
    return Container(
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tickets: ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Visitor: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "   " + user.name + " " + user.surname,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: color.highlightColor),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Museum: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "   " + museumData.name,
                              style: TextStyle(
                                  color: color.highlightColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Selected date of visit: ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "   " + date.format(billData.date),
                              style: TextStyle(
                                  color: color.accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "   " + billData.museumTime.format(context),
                              style: TextStyle(
                                  color: color.accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Used ticket:  ",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "   " + billData.isUsed.toString(),
                              style: TextStyle(
                                  color: color.accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButtonSetings('Reject ticket', () {
              setState(() {
                result = null;
              });
            }),
            const SizedBox(height: 50),
            ElevatedButtonSetings('Allow entrance', () async {
              billData.isUsed = true;
              await DBCaller.updateBill(billData);
              setState(() {
                result = null;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget showVisitorsScreen(
      BuildContext context,
      MediaQueryData mediaQuery,
      TextStyle textTheme,
      List<Bill> billsTodayForMuseum,
      List<UserTicket> boughtTickets) {
    return Column(
      children: [
        Container(
          height: 400,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextForRow(
                    textTheme: textTheme,
                    expanded: 2,
                    title: 'Buyer',
                  ),
                  TextForRow(
                      textTheme: textTheme, expanded: 1, title: 'Tickets'),
                  TextForRow(
                      textTheme: textTheme, expanded: 1, title: 'Entrance'),
                  TextForRow(textTheme: textTheme, expanded: 1, title: 'Paid'),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: billsTodayForMuseum.isEmpty
                    ? Text('No tickets for today')
                    : ListView.builder(
                        itemCount: billsTodayForMuseum.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            TicketValidationRowData(
                                billsTodayForMuseum[i].id, boughtTickets),
                            const Divider(thickness: 1),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
