// ignore_for_file: unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/providers/tickets.dart';
import '../firebase_managers/db_caller.dart';
import '../models/user_ticket.dart';

class UserTickets with ChangeNotifier {
  List<UserTicket> _userTickets = [
    // UserTicket(
    //   billId: '1',
    //   ticketId: '1',
    //   quantity: 2,
    // ),
    // UserTicket(
    //   billId: '2',
    //   ticketId: '1',
    //   quantity: 2,
    // ),
    // UserTicket(
    //   billId: '2',
    //   ticketId: '2',
    //   quantity: 1,
    // ),
    // UserTicket(
    //   billId: '3',
    //   ticketId: '2',
    //   quantity: 1,
    // ),
    // UserTicket(
    //   billId: '4',
    //   ticketId: '2',
    //   quantity: 1,
    // ),
  ];

  Future<void> fetchUserTickets() async {
    List<UserTicket> loadedUserTickets = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("userTickets").get();
    for (var doc in querySnapshot.docs) {
      loadedUserTickets.add(UserTicket.fromSnap(doc));
    }
    _userTickets.clear();
    _userTickets = loadedUserTickets;
    print("Loaded user tickets: " + _userTickets.length.toString());
    notifyListeners();
  }

  List<UserTicket> _newUserTickets = [];

  void clearNewTickets() {
    _newUserTickets = [];
    notifyListeners();
  }

  List<UserTicket> getAllTicketsForMuseumTicket(String ticketId) {
    return _userTickets
        .where((element) => element.ticketId == ticketId)
        .toList();
  }

  void addUserTickets(UserTicket newUserTicket) {
    int index = _newUserTickets.indexWhere((userTicket) =>
        (userTicket.billId == newUserTicket.billId &&
            userTicket.ticketId == newUserTicket.ticketId));
    if (index == -1) {
      _newUserTickets.add(newUserTicket);
    } else if (newUserTicket.quantity == 0) {
      _newUserTickets.removeAt(index);
    } else {
      _newUserTickets[index] = newUserTicket;
    }
    notifyListeners();
  }

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

  Future<void> addNewUserTicket(String billId) async {
    int newUserTicketsLenght = _newUserTickets.length;

    for (int i = 0; i < newUserTicketsLenght; i++) {
      _newUserTickets[i].billId = billId;
      await DBCaller.addUserTicket(_newUserTickets[i]);
    }
    clearNewTickets();
    notifyListeners();
  }

  void deleteUserTicket(String billId) {
    _userTickets
        .removeWhere((userTicketData) => userTicketData.billId == billId);
  }

  List getTicketIds(List billIds) {
    var ticketIds = [];
    for (var i = 0; i < billIds.length; i++) {
      ticketIds.add(_userTickets
          .firstWhere((userTicketData) => userTicketData.billId == billIds[i])
          .ticketId);
    }
    return ticketIds;
  }
}
