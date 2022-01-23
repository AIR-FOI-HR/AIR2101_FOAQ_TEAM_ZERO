import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tickets.dart';

class TicketConfiguration extends StatelessWidget {
  final String muesumId;

  TicketConfiguration(this.muesumId);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final ticketListData = Provider.of<Tickets>(context).getTickets(muesumId);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Tickets',
                style: color.textTheme.headline5,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.65,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: ListView.builder(
                  itemCount: ticketListData.length,
                  itemBuilder: (_, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'name: ${ticketListData[i].name} cost: ${ticketListData[i].cost}'),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
