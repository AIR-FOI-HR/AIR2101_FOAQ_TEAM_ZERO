import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class BuyTicketScreen extends StatelessWidget {
  static const routeName = "/buy-tickets"; //namedroute for buy ticket screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Buy tickets', context, Theme.of(context).primaryColor),
      body: Text('id muzeja je: ' + ModalRoute.of(context).settings.arguments),
    );
  }
}
