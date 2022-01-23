import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tickets.dart';
import '../../screens/single_musem_configuration/ticket_crud_screen.dart';
import './single_ticket_item.dart';

class TicketConfiguration extends StatelessWidget {
  final String muesumId;

  TicketConfiguration(this.muesumId);

  @override
  Widget build(BuildContext context) {
    final ticketListData =
        Provider.of<Tickets>(context, listen: false).getTickets(muesumId);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final color = Theme.of(ctx);
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
                      SingleTicketItem(ticketListData[i]),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: color.highlightColor,
                child: IconButton(
                  color: color.primaryColor,
                  splashRadius: 30,
                  iconSize: 35,
                  icon: const Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(TicketCrudScreen.routeName);
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
