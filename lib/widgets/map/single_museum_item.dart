import 'package:flutter/material.dart';

import '../../models/museum.dart';

class SingleMuseumItem extends StatelessWidget {
  Museum museumData;

  SingleMuseumItem(this.museumData);

  @override
  Widget build(BuildContext context) {
    final city = museumData.address.substring(
        museumData.address.indexOf(',') + 1, museumData.address.length);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(museumData.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.pin_drop_outlined,
                    size: 21,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                TextSpan(
                  text: city,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
