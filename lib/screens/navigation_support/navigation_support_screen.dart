import 'package:flutter/material.dart';
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
  final String username = 'ttomiek';
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final appBarProperty =
        appBar('Navigation support', context, color.primaryColor);
    final mediaQuery = MediaQuery.of(context);

    final User userData =
        Provider.of<Users>(context, listen: false).findByUsername(username);
    final billIds =
        Provider.of<Bills>(context, listen: false).getBillIds(userData.id);
    final ticketIds =
        Provider.of<UserTickets>(context, listen: false).getTicketIds(billIds);
    var museumIds =
        Provider.of<Tickets>(context, listen: false).getMuseumIds(ticketIds);

    if (userData.userRole == '1' && userData.museumId != null) {
      museumIds = [userData.museumId];
    }
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  SizedBox(
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
      ),
    );
  }
}
