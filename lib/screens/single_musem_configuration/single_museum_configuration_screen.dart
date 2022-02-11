import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/museums.dart';
import '../../providers/users.dart';
import '../../providers/tickets.dart';

import '../../models/user.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/ticket_configuration/ticket_configuration.dart';
import '../../widgets/museum_work_time/museum_work_time.dart';
import '../../widgets/single_musum_inforamtion/single_museum_inforamtion.dart';
import '../../widgets/museum_tour_duration/museum_tour_duration.dart';

class SingleMuseumConfigurationScreen extends StatelessWidget {
  static const routeName = '/SingleMuseumConfiguration';
  final logedUserUsername = 'ttomiek';

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();

    Future<void> _fetchMuseumData() async {
      Provider.of<Tickets>(context, listen: false).fetchTickets();
      await Future.delayed(Duration(milliseconds: 700));
    }

    final museumData = Provider.of<Museums>(context).getById(appUser.museumId);
    final divider = Divider(
      thickness: 2,
      color: Theme.of(context).primaryColor,
    );

    final color = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('Museum configuration', context, color.primaryColor, appUser);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: FutureBuilder(
          future: _fetchMuseumData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: color.primaryColor,
                      ),
                      width: double.infinity,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            museumData.name,
                            style: color.textTheme.headline1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBarProperty.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.50,
                      child: TicketConfiguration(museumData.id),
                    ),
                    divider,
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBarProperty.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.50,
                      child: MuseumWorkTime(museumData.id),
                    ),
                    divider,
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBarProperty.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: SingleMuseumInformation(museumData.id),
                    ),
                    divider,
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBarProperty.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: MuseumTourDuration(museumData.id),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
