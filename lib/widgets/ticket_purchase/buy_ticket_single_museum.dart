import 'package:flutter/material.dart';

import '../../models/museum.dart';
import './museum_image.dart';
import './first_colmn.dart';
import './second_column.dart';

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
            if (side)
              Expanded(
                flex: 3,
                child: MuseumImage(museumData.imageUrl),
              ),
            Expanded(
              flex: 3,
              child: FirstColumn(museumData),
            ),
            VerticalDivider(
              thickness: 1,
              color: color.highlightColor,
            ),
            Expanded(
              flex: 2,
              child: SecondColumn(museumData),
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

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return ((index % 2 == 0) || (index == 0))
        ? itemDesign(context, true)
        : itemDesign(context, false);
  }
}
