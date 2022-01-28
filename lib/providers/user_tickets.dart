// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../models/user_ticket.dart';

class UserTickets with ChangeNotifier {
  List<UserTicket> _userTickets = [
    UserTicket(
      billId: '1',
      ticketId: '1',
      quantity: 2,
    ),
    UserTicket(
      billId: '2',
      ticketId: '1',
      quantity: 2,
    ),
    UserTicket(
      billId: '2',
      ticketId: '2',
      quantity: 1,
    ),
  ];

  List<UserTicket> getUserTicket(String userTicketId) {
    return _userTickets
        .where((userTicektData) => userTicektData.billId == userTicketId)
        .toList();
  }

  void addNewUserTicket(UserTicket newUserTicket) {
    _userTickets.add(newUserTicket);
    notifyListeners();
  }
}
