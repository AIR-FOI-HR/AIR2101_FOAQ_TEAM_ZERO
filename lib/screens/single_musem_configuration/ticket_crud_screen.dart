import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class TicketCrudScreen extends StatelessWidget {
  static const routeName = '/EditTicket';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Scaffold(
      appBar: appBar('Edit ticket', context, color.primaryColor),
      body: Text('dada'),
    );
  }
}
