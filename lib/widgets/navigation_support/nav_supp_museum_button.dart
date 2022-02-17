import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../providers/museums.dart';

import '../../screens/navigation_support/museum_nav_supp_screen.dart';

class NavSuppMuseumButton extends StatelessWidget {
  final String museumId;
  final List categoryList;

  NavSuppMuseumButton(this.museumId, this.categoryList);

  @override
  Widget build(BuildContext context) {
    final Museum museumData =
        Provider.of<Museums>(context, listen: false).getById(museumId);
    print(categoryList);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).highlightColor,
          boxShadow: kElevationToShadow[6],
        ),
        child: FlatButton(
          child: Text(
            museumData.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: () {
            categoryList == null
                ? Navigator.of(context).pushReplacementNamed(
                    MuseumNavSuppScreen.routeName,
                    arguments: {
                        'museumId': museumData.id,
                        'categoryList': null,
                      })
                : Navigator.of(context).pushReplacementNamed(
                    MuseumNavSuppScreen.routeName,
                    arguments: {
                        'museumId': museumData.id,
                        'categoryList': categoryList,
                      });
          },
        ));
  }
}
