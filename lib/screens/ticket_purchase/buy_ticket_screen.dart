import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../widgets/buy_tickets/work_time_item.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buy_tickets/museum_column_data.dart';
import '../../widgets/my_reservations/elevated_button_my_reservation.dart';

import '../../models/museum.dart';
import '../../models/work_time.dart';

import '../../providers/museums.dart';
import '../../providers/artworks.dart';
import '../../providers/categories.dart';
import '../../providers/work_times.dart';

class BuyTicketScreen extends StatefulWidget {
  static const routeName = "/buy-tickets";

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
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

  @override
  Widget build(BuildContext context) {
    final museumId = ModalRoute.of(context).settings.arguments as String;
    final color = Theme.of(context);
    final appBarProperty = appBar('Buy tickets', context, color.primaryColor);
    final mediaQuery = MediaQuery.of(context);

    List artworkProv =
        Provider.of<Artworks>(context).getCategoryFromMuseum(museumId);
    String categoryNames =
        Provider.of<Categories>(context).getCategoryName(artworkProv);

    final museumProv = Provider.of<Museums>(context);
    final Museum museumData = museumProv.getById(museumId);
    int museumTourDuration =
        museumProv.getMuseumTourDuration(museumData.id).toInt();

    final workTimeProv = Provider.of<WorkTimes>(context, listen: false);
    final WorkTime workTimeData =
        workTimeProv.getTheWorkTimeOfSelectedDay(museumId, selectedDate);
    final workTimeSections = workTimeProv.getWorkTimeSections(
        workTimeData, museumTourDuration, context);

    final DateFormat date = DateFormat('dd.MM.yyyy.');
    return Scaffold(
      appBar: appBarProperty,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: (mediaQuery.size.height -
                  appBarProperty.preferredSize.height -
                  mediaQuery.padding.top) *
              0.4,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(5),
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
                        const SizedBox(height: 10),
                        MuseumColumnData(workTimeData.timeFrom == null ||
                                workTimeData.timeTo == null
                            ? 'Work time:\nClosed'
                            : 'Work time:\n${workTimeData.timeFrom.format(context)} - ${workTimeData.timeTo.format(context)}'),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topLeft,
                          child: ElevatedButtonMyReservation(
                              'Select date', () => _selectDate(context)),
                        ),
                        const SizedBox(height: 5),
                        MuseumColumnData(
                            'Selectad date:\n${date.format(selectedDate.toLocal())}'),
                      ],
                    ),
                  ),
                  if (workTimeSections.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: SizedBox(
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
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
