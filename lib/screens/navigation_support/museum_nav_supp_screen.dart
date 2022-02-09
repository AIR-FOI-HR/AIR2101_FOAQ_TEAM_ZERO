import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/navigation_support/nav_supp_point_item.dart';
import '../../widgets/my_reservations/elevated_button_my_reservation.dart';

import '../../providers/museums_halls.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';
import '../../models/museum_halls.dart';
import '../../models/museum.dart';

class MuseumNavSuppScreen extends StatelessWidget {
  static const routeName = '/museumNavSupp';
  final String loggedUsername = 'ttomiek';

  @override
  Widget build(BuildContext context) {
    final museumId = ModalRoute.of(context).settings.arguments as String;
    final color = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('Navigation support', context, color.primaryColor);

    final Museum museumData = Provider.of<Museums>(context).getById(museumId);
    final List<MuseumHalls> museumHallsData =
        Provider.of<MuseumsHalls>(context, listen: false)
            .getMuseumHallsById(museumId);
    final loggedUserData =
        Provider.of<Users>(context).findByUsername(loggedUsername);
    final bool admin =
        loggedUserData.userRole == '1' && loggedUserData.museumId != null
            ? true
            : false;
    return Scaffold(
      appBar: appBarProperty,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  museumData.name,
                  style: color.textTheme.headline5,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButtonMyReservation(
                    'Back',
                    () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  (admin ? 0.80 : 0.88),
              child: ListView.builder(
                itemCount: museumHallsData.length,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      NavSuppPointItem(museumHallsData[i]),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            if (admin)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: color.buttonColor,
                  child: IconButton(
                    color: color.shadowColor,
                    highlightColor: color.buttonColor,
                    splashRadius: 30,
                    iconSize: 35,
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
