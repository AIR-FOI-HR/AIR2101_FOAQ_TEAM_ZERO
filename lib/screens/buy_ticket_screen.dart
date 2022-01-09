import 'package:flutter/material.dart';

class BuyTicketScreen extends StatelessWidget {
  static const routeName="/buy-tickets"; //namedroute for buy ticket screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buy ticket'),),
    );
  }
}