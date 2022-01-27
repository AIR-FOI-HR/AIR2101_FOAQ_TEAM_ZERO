import 'package:flutter/material.dart';

import '../../models/museum.dart';
import './museum_image.dart';
import './first_colmn.dart';

class BuyTicketSingleMuseum extends StatelessWidget {
  final Museum museumData;
  final int index;

  BuyTicketSingleMuseum(this.museumData, this.index);

  Widget itemDesign(BuildContext context, bool side) {
    final color = Theme.of(context);
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Row(
          children: [
            if (side) MuseumImage(museumData.imageUrl),
            FirstColumn(museumData),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      museumData.name,
                      style: color.textTheme.headline5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      museumData.address,
                      style: color.textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
            if (!side) MuseumImage(museumData.imageUrl),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return ((index % 2 == 0) || (index == 0))
        ? itemDesign(context, true)
        : itemDesign(context, false);
  }
}
