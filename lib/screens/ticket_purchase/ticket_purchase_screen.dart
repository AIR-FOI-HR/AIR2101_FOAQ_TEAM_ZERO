import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';

class TicketPurchaseScreen extends StatelessWidget {
  static const routeName = '/TicketPurchase';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Scaffold(
      appBar: appBar('Tickets', context, color.primaryColor),
      drawer: MainMenuDrawer(),
      body: Text('proba'),
    );
  }
}
