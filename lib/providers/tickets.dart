// ignore_for_file: unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [
    // Ticket(
    //   id: '1',
    //   name: 'Adult',
    //   cost: '10.00',
    //   museumId: '1',
    // ),
    // Ticket(
    //   id: '2',
    //   name: 'Students',
    //   cost: '5.00',
    //   museumId: '1',
    // ),
    // Ticket(
    //   id: '3',
    //   name: 'Family pack',
    //   cost: '20.00',
    //   museumId: '1',
    // ),
    // Ticket(
    //   id: '4',
    //   name: 'Family pack',
    //   cost: '25.00',
    //   museumId: '1',
    // ),
  ];

  Future<void> fetchTickets() async {
    List<Ticket> loadedTickets = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("tickets").get();
    for (var doc in querySnapshot.docs) {
      loadedTickets.add(Ticket.fromSnap(doc));
    }
    _tickets.clear();
    _tickets = loadedTickets;
    print("Tickets: " + _tickets.length.toString());
    notifyListeners();
  }

  List<Ticket> getTickets(String museumId) {
    return _tickets
        .where((ticketData) => ticketData.museumId == museumId)
        .toList();
  }

  String getMuseumIdByTicketId(String ticketId) {
    return _tickets
        .firstWhere((ticketData) => ticketData.id == ticketId,
            orElse: () => null)
        .museumId;
  }

  Ticket findById(String ticketId) {
    return _tickets.firstWhere((ticketData) => ticketData.id == ticketId);
  }

  void deleteTicketById(String ticketId) {
    _tickets.removeWhere((ticketData) => ticketData.id == ticketId);
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
