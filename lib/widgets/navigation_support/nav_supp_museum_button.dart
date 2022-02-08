import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../providers/museums.dart';

import '../../screens/navigation_support/museum_nav_supp_screen.dart';

class NavSuppMuseumButton extends StatelessWidget {
  final String museumId;

  NavSuppMuseumButton(this.museumId);

  @override
  Widget build(BuildContext context) {
    final Museum museumData = Provider.of<Museums>(context).getById(museumId);
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
            Navigator.of(context).pushNamed(MuseumNavSuppScreen.routeName,
                arguments: museumData.id);
          },
        ));
  }
}
