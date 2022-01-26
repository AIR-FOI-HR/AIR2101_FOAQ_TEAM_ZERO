import 'package:flutter/material.dart';

import '../../widgets/main_menu_drawer.dart';
import '../../widgets/ticket_purchase/buy_ticket.dart';

class TicketPurchaseScreen extends StatelessWidget {
  static const routeName = '/TicketPurchase';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);

    final appBarProperty = AppBar(
      title: const Text('Tickets'),
      backgroundColor: color.primaryColor,
      bottom: TabBar(
        indicatorColor: color.highlightColor,
        labelStyle: color.textTheme.headline4,
        tabs: const [
          Tab(text: 'Buy tickets'),
          Tab(text: 'My reservations'),
        ],
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBarProperty,
        drawer: MainMenuDrawer(),
        body: TabBarView(
          children: [
            BuyTicket(),
            Text('Todo'),
          ],
        ),
      ),
    );
  }
}
