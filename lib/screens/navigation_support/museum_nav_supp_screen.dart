import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:provider/provider.dart';

import './navigation_support_screen.dart';
import './museum_nav_supp_crud_screen.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/navigation_support/nav_supp_point_item.dart';
import '../../widgets/my_reservations/elevated_button_my_reservation.dart';

import '../../providers/museums_halls.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';
import '../../models/museum_halls.dart';
import '../../models/museum.dart';

class MuseumNavSuppScreen extends StatelessWidget {
  static const routeName = '/museumNavSupp';
  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    final museumId = arguments['museumId'].toString();
    final categoryList = arguments['categoryList'];

    final color = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('Navigation support', context, color.primaryColor, appUser);

    final Museum museumData =
        Provider.of<Museums>(context, listen: false).getById(museumId);
    final museumHallProv = Provider.of<MuseumsHalls>(context);
    final List<MuseumHalls> museumHallsData = categoryList == null
        ? museumHallProv.getMuseumHallsById(museumId)
        : museumHallProv.getRecomendedRoute(museumId, categoryList);
    final bool admin = (appUser.userRole == '2' || appUser.userRole == '3') &&
            appUser.museumId != ""
        ? true
        : false;
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
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
                        Navigator.of(context).pushReplacementNamed(
                            NavigationSupportScreen.routeName);
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
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            MuseumNavSuppCrudScreen.routeName,
                            arguments: {'museumId': museumId});
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
