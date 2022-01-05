// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../screens/museum_detail_screen.dart';

class MuseumGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final museum = Provider.of<Museum>(context, listen: false);
    final city = museum.address
        .substring(museum.address.indexOf(',') + 1, museum.address.length);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MuseumDetailScreen.routeName);
            },
            child: Image.asset(museum.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.pin_drop_outlined,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                TextSpan(
                    text: city,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w300
                    )),
              ],
            ),
          ),
        ),
        header: GridTileBar(
          trailing: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.7),
            ),
            child: Text(
              '${museum.name}',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
