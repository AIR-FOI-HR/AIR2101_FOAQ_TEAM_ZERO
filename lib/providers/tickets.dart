// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [
    Ticket(
      id: '1',
      name: 'Adult',
      cost: '10.00',
      museumId: '1',
    ),
    Ticket(
      id: '2',
      name: 'Students',
      cost: '5.00',
      museumId: '1',
    ),
    Ticket(
      id: '3',
      name: 'Family pack',
      cost: '20.00',
      museumId: '1',
    ),
    Ticket(
      id: '4',
      name: 'Family pack',
      cost: '25.00',
      museumId: '1',
    ),
  ];

  List<Ticket> getTickets(String id) {
    return _tickets.where((ticketData) => ticketData.museumId == id).toList();
  }

  Ticket findById(String id) {
    return _tickets.firstWhere((ticketData) => ticketData.id == id);
  }

  void deleteTicketById(String id) {
    _tickets.removeWhere((ticketData) => ticketData.id == id);
    notifyListeners();
  }

  void addNewTicket(Ticket ticket) {
    final newTicket = Ticket(
        id: (_tickets.length + 1).toString(),
        name: ticket.name,
        cost: ticket.cost,
        museumId: ticket.museumId);
    _tickets.add(newTicket);
    notifyListeners();
  }

  void updateTicket(Ticket newTicket) {
    final prodIndex = _tickets.indexWhere((prod) => prod.id == newTicket.id);
    if (prodIndex >= 0) {
      _tickets[prodIndex] = newTicket;
      notifyListeners();
    }
  }
}
