import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';
import '../../widgets/ticket_configuration/ticket_configuration.dart';

class SingleMuseumConfigurationScreen extends StatelessWidget {
  static const routeName = '/SingleMuseumConfiguration';
  final logedUserUsername = 'ttomiek';

  @override
  Widget build(BuildContext context) {
    final loggedUserData =
        Provider.of<Users>(context).findByUsername(logedUserUsername);
    final museumData =
        Provider.of<Museums>(context).getById(loggedUserData.museumId);
    final divider = Divider(
      thickness: 2,
      color: Theme.of(context).primaryColor,
    );
    final color = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('Museum configuration', context, color.primaryColor);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                  0.4,
              child: TicketConfiguration(museumData.id),
            ),
            divider,
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: Text('TOO DOO need a work time block'),
            ),
            divider,
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: Text('TOO DOO need a museum information blok'),
            ),
            divider,
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: Text('TOO DOO need a tour duration block'),
            ),
          ],
        ),
      ),
    );
  }
}
