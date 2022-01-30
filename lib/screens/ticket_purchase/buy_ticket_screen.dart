import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/buy_tickets/museum_column_data.dart';

import '../../models/museum.dart';

import '../../providers/museums.dart';
import '../../providers/artworks.dart';
import '../../providers/categories.dart';

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

    final TextStyle textStyle = color.textTheme.headline4;
    final Museum museumData = Provider.of<Museums>(context).getById(museumId);
    return Scaffold(
      appBar: appBarProperty,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: (mediaQuery.size.height -
                  appBarProperty.preferredSize.height -
                  mediaQuery.padding.top) *
              0.35,
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
                        MuseumColumnData(
                            '${selectedDate.toLocal()}'.split(' ')[0]),
                        const SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () => _selectDate(context), // Refer step 3
                          child: const Text(
                            'Select date',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
