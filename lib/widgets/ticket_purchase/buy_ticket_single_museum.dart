import 'package:flutter/material.dart';

import '../../models/museum.dart';

class BuyTicketSingleMuseum extends StatelessWidget {
  final Museum museumData;

  BuyTicketSingleMuseum(this.museumData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Text(museumData.name),
    );
  }
}
