// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [
    Ticket(
      id: 't1',
      name: 'Adult',
      cost: 10.00,
      museumId: '1',
    ),
    Ticket(
      id: 't2',
      name: 'Students',
      cost: 5.00,
      museumId: '1',
    ),
    Ticket(
      id: 't3',
      name: 'Family pack',
      cost: 20.00,
      museumId: '1',
    ),
  ];

  List getTickets(String id) {
    return [..._tickets.where((ticketData) => ticketData.id == id)];
  }
}
