import 'package:flutter/material.dart';

import '../../models/museum.dart';
import './museum_image.dart';
import './first_colmn.dart';

class BuyTicketSingleMuseum extends StatelessWidget {
  final Museum museumData;
  final int index;

  BuyTicketSingleMuseum(this.museumData, this.index);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return ((index % 2 == 0) || (index == 0))
        ? itemDesign(context, true)
        : itemDesign(context, false);
  }

  Widget itemDesign(BuildContext context, bool side) {
    return SizedBox(
      height: 170,
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Row(
          children: [
            if (side)
              Expanded(
                flex: 3,
                child: MuseumImage(museumData.imageUrl),
              ),
            Expanded(
              flex: 4,
              child: FirstColumn(museumData),
            ),
            if (!side)
              Expanded(
                flex: 3,
                child: MuseumImage(museumData.imageUrl),
              ),
          ],
        ),
      ),
    );
  }
}
