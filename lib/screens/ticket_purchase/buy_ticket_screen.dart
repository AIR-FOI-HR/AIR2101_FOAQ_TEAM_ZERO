import 'package:flutter/material.dart';
import 'package:museum_app/models/bill.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/ticket_purchase/ticket_purchase_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../firebase_managers/db_caller.dart';

import '../../widgets/buy_tickets/work_time_item.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buy_tickets/museum_column_data.dart';
import '../../widgets/my_reservations/elevated_button_my_reservation.dart';
import '../../widgets/buy_tickets/ticket_data_row.dart';

import '../../models/museum.dart';
import '../../models/work_time.dart';

import '../../providers/tickets.dart';
import '../../providers/museums.dart';
import '../../providers/artworks.dart';
import '../../providers/categories.dart';
import '../../providers/work_times.dart';
import '../../providers/bills.dart';
import '../../providers/user_tickets.dart';

class BuyTicketScreen extends StatefulWidget {
  static const routeName = "/buy-tickets";

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  var _isInit = true;
  String newBillId;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final billsProv = Provider.of<Bills>(context, listen: false);
      newBillId = billsProv.createNewBill();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
          backgroundColor: Colors.transparent,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        'Improperly filled',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
      content: const Text("Please fill in the museum ticket correctly."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    final museumId = ModalRoute.of(context).settings.arguments as String;
    final color = Theme.of(context);
    final appBarProperty =
        appBar('Buy tickets', context, color.primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);

    List artworkProv =
        Provider.of<Artworks>(context).getCategoryFromMuseum(museumId);
    String categoryNames =
        Provider.of<Categories>(context).getCategoryName(artworkProv);

    final museumProv = Provider.of<Museums>(context, listen: false);
    final Museum museumData = museumProv.getById(museumId);
    int museumTourDuration =
        museumProv.getMuseumTourDuration(museumData.id).toInt();

    final workTimeProv = Provider.of<WorkTimes>(context);
    final WorkTime workTimeData =
        workTimeProv.getTheWorkTimeOfSelectedDay(museumId, selectedDate);
    final workTimeSections = workTimeProv.getWorkTimeSections(
        workTimeData, museumTourDuration, context);

    final ticketsProv = Provider.of<Tickets>(context);
    final ticketData = ticketsProv.getTickets(museumId);

    final billProv = Provider.of<Bills>(context);
    final double totalAmount = billProv.getBillTotalAmount(newBillId);

    final DateFormat date = DateFormat('dd.MM.yyyy.');
    return Scaffold(
      appBar: appBarProperty,
      body: Column(
        children: [
          Container(
            height: (mediaQuery.size.height -
                    appBarProperty.preferredSize.height -
                    mediaQuery.padding.top) *
                0.4,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    museumData.name,
                    style: color.textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            MuseumColumnData(museumData.address),
                            const SizedBox(height: 10),
                            MuseumColumnData('Categories: $categoryNames'),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.topLeft,
                              child: ElevatedButtonMyReservation(
                                  'Select date', () => _selectDate(context)),
                            ),
                            const SizedBox(height: 5),
                            MuseumColumnData(
                                'Selected date:\n${date.format(selectedDate.toLocal())}'),
                            const SizedBox(height: 10),
                            MuseumColumnData(workTimeData.timeFrom == null ||
                                    workTimeData.timeTo == null
                                ? 'Work time:\nClosed'
                                : 'Work time:\n${workTimeData.timeFrom.format(context)} - ${workTimeData.timeTo.format(context)}'),
                          ],
                        ),
                      ),
                      if (workTimeSections.isNotEmpty)
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                'Please select time:',
                                style: color.textTheme.headline4,
                              ),
                              SizedBox(
                                height: (mediaQuery.size.height -
                                        appBarProperty.preferredSize.height -
                                        mediaQuery.padding.top) *
                                    0.3,
                                child: GridView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: workTimeSections.length,
                                  itemBuilder: (ctx, i) =>
                                      WorkTimeItem(workTimeSections[i]),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 8 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: (mediaQuery.size.height -
                    appBarProperty.preferredSize.height -
                    mediaQuery.padding.top) *
                0.56,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tickets',
                    style: color.textTheme.headline5,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 200,
                    child: ListView.builder(
                      itemCount: ticketData.length,
                      itemBuilder: (_, i) {
                        return Column(
                          children: [
                            TicketDataRow(ticketData[i], i, newBillId),
                            const Divider(thickness: 1),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Total: ${totalAmount.toStringAsFixed(2)} €',
                      style: color.textTheme.headline5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButtonMyReservation('Proceed to checkout',
                        () async {
                      if (totalAmount == 0.0 ||
                          billProv.getSelectedTime() == null) {
                        showAlertDialog(context);
                      } else {
                        Bill newBill = Bill(
                            id: newBillId,
                            date: selectedDate,
                            totalCost: totalAmount,
                            userId: appUser.id,
                            isCanceled: false,
                            museumTime: billProv.getSelectedTime(),
                            purchaseDateTime: DateTime.now());
                        await DBCaller.addBill(newBill).then((value) async {
                          await Provider.of<UserTickets>(context, listen: false)
                              .addNewUserTicket(value);
                        });
                        Navigator.of(context).pushReplacementNamed(
                            TicketPurchaseScreen.routeName,
                            arguments: 1);
                      }
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
