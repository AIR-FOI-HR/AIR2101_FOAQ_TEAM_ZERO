import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';

class SingleMuseumConfigurationScreen extends StatelessWidget {
  static const routeName = '/SingleMuseumConfiguration';

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: Text('TOO DOO need a ticket price list'),
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
