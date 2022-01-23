import 'package:flutter/material.dart';

import '../../models/ticket.dart';

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
              flex: 5,
              child: Text(
                ticketData.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                '${ticketData.cost}€',
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
                  onPressed: () {},
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
