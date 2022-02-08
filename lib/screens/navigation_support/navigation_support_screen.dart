import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';

import '../../widgets/navigation_support/nav_supp_museum_button.dart';

class NavigationSupportScreen extends StatelessWidget {
  static const routeName = '/navigationSupport';
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final appBarProperty =
        appBar('Naviagtion support', context, color.primaryColor);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose:',
                    style: color.textTheme.headline5,
                  ),
                  NavSuppMuseumButton('1'),
                  NavSuppMuseumButton('1'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
