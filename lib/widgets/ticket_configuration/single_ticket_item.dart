import 'package:flutter/material.dart';

import '../../models/ticket.dart';
import '../../screens/single_musem_configuration/ticket_crud_screen.dart';

class SingleTicketItem extends StatelessWidget {
  final Ticket ticketData;

  SingleTicketItem(this.ticketData);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                ticketData.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${ticketData.cost} €',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 30,
                child: IconButton(
                  highlightColor: color.primaryColorLight,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pushNamed(TicketCrudScreen.routeName,
                        arguments: ticketData.id);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
            )
          ],
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
