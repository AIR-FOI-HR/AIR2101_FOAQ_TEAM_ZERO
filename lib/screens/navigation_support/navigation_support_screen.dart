import 'package:flutter/material.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:museum_app/providers/categories.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/museums_halls.dart';
import 'package:museum_app/providers/work_times.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/navigation_support/nav_supp_museum_button.dart';

import '../../models/user.dart';

import '../../providers/users.dart';
import '../../providers/bills.dart';
import '../../providers/user_tickets.dart';
import '../../providers/tickets.dart';

class NavigationSupportScreen extends StatelessWidget {
  static const routeName = '/navigationSupport';

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    final color = Theme.of(context);
    final appBarProperty =
        appBar('Navigation support', context, color.primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);
    final billIds =
        Provider.of<Bills>(context, listen: false).getBillIds(appUser.id);
    final ticketIds =
        Provider.of<UserTickets>(context, listen: false).getTicketIds(billIds);
    var museumIds =
        Provider.of<Tickets>(context, listen: false).getMuseumIds(ticketIds);

    if (int.parse(appUser.userRole) > 1 && appUser.museumId != "") {
      museumIds = [appUser.museumId];
    }
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: FutureBuilder(
          future: _refreshAllData(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose:',
                            style: color.textTheme.headline5,
                          ),
                          museumIds.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'You do not have any museum tickets reserved, please purchase' +
                                        ' a museum ticket to show the navigation support of a particular museum',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : SizedBox(
                                  height: (mediaQuery.size.height -
                                          appBarProperty.preferredSize.height -
                                          mediaQuery.padding.top) *
                                      0.3,
                                  child: ListView.builder(
                                    itemCount: museumIds.length,
                                    itemBuilder: (_, i) {
                                      return NavSuppMuseumButton(museumIds[i]);
                                    },
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<void> _refreshAllData(BuildContext context) async {
    await Provider.of<Museums>(context, listen: false).fetchMuseums();
    await Provider.of<Artworks>(context, listen: false).fetchArtworks();
    await Provider.of<Tickets>(context, listen: false).fetchTickets();
    await Provider.of<Categories>(context, listen: false).fetchCategories();
    await Provider.of<WorkTimes>(context, listen: false).fetchWorkTimes("");
    await Provider.of<UserTickets>(context, listen: false).fetchUserTickets();
    await Provider.of<Bills>(context, listen: false).fetchBills();
    await Provider.of<MuseumsHalls>(context, listen: false).fetchMuseumHalls();
    await Future.delayed(Duration(milliseconds: 700));
  }
}
