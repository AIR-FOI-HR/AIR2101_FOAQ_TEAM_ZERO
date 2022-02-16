import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_bar.dart';
import '../widgets/main_menu_drawer.dart';
import '../widgets/map/single_museum_item.dart';

import '../models/user.dart';
import '../models/museum.dart';

import '../providers/museums.dart';
import '../providers/users.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/museumMap';

  void _launchURL(String url) async {
    if (url == null) {
      return;
    }
    if (!await launch(url)) throw 'Could not open $url';
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    List<Museum> museumList =
        Provider.of<Museums>(context).getMuseumAndLocation;

    final color = Theme.of(context);
    final appBarProperty =
        appBar('Museums maps', context, color.primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please select the desired museum to display on the map:',
              style: color.textTheme.headline5,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.85,
              child: ListView.builder(
                  itemCount: museumList.length,
                  itemBuilder: (ctx, i) {
                    return ElevatedButton(
                      onPressed: () {
                        _launchURL(museumList[i].location);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            museumList[i].name,
                            style: color.textTheme.headline5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: 150,
                            child: SingleMuseumItem(museumList[i]),
                          ),
                          Divider(
                            thickness: 3,
                            color: color.highlightColor,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
