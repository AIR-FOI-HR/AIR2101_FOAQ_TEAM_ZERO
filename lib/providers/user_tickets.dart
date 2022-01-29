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
    UserTicket(
      billId: '3',
      ticketId: '2',
      quantity: 1,
    ),
    UserTicket(
      billId: '4',
      ticketId: '2',
      quantity: 1,
    ),
  ];

  int getSpecificUserTicket(String billId, String ticketId) {
    List<UserTicket> userTickets = getUserTicket(billId);
    return userTickets
        .firstWhere((userTicketsData) => userTicketsData.ticketId == ticketId)
        .quantity;
  }

  String getUserTicketIdByBillId(String billId) {
    return _userTickets
        .firstWhere((userTicektData) => userTicektData.billId == billId)
        .ticketId;
  }

  List<UserTicket> getUserTicket(String billId) {
    return _userTickets
        .where((userTicektData) => userTicektData.billId == billId)
        .toList();
  }

  void addNewUserTicket(UserTicket newUserTicket) {
    _userTickets.add(newUserTicket);
    notifyListeners();
  }

  void deleteUserTicket(String billId) {
    _userTickets
        .removeWhere((userTicketData) => userTicketData.billId == billId);
  }
}
