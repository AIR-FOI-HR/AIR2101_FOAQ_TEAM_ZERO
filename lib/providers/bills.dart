// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../models/bill.dart';

class Bills with ChangeNotifier {
  List<Bill> _bills = [
    Bill(
      id: '1',
      date: DateTime.parse('2022-03-14 20:18:04Z'),
      totalCost: 20.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 14, minute: 0),
    ),
    Bill(
      id: '2',
      date: DateTime.parse('2022-03-16 12:38:04Z'),
      totalCost: 25.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 10, minute: 0),
    ),
    Bill(
      id: '3',
      date: DateTime.parse('2022-02-21 09:30:09Z'),
      totalCost: 5.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 15, minute: 30),
    ),
    Bill(
      id: '4',
      date: DateTime.parse('2022-02-21 09:30:09Z'),
      totalCost: 5.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 15, minute: 30),
    ),
  ];

  TimeOfDay selectedTime;

  TimeOfDay getSelectedTime() {
    return selectedTime;
  }

  void setSelectedTime(TimeOfDay userSelectedTime) {
    selectedTime = userSelectedTime;
    notifyListeners();
  }

  Bill getBillsById(String billId) {
    return _bills.firstWhere((billData) => billData.id == billId);
  }

  List<Bill> getBills(String userId) {
    return _bills.where((billData) => billData.userId == userId).toList();
  }

  String getDataFromDate(DateTime billDate) {
    if (billDate.compareTo(DateTime.now()) > 0) {
      return 'Reservated';
    }
    return 'Done';
  }

  String getButtonDataFromDate(Bill billData) {
    String buttonData = getDataFromDate(billData.date);
    if (buttonData == 'Done' || billData.isCanceled) {
      return 'Delete';
    }
    return 'Cancel';
  }

  String createNewBill() {
    final newBill = Bill(
      id: (_bills.length + 1).toString(),
      date: null,
      totalCost: 0,
      userId: '',
    );
    _bills.add(newBill);
    return newBill.id;
  }

  void updateBillTotalAmount(String billId, double price) {
    final Bill billData =
        _bills.firstWhere((billData) => billData.id == billId);
    int index = _bills.indexWhere((billData) => billData.id == billId);

    _bills[index] = Bill(
      id: billData.id,
      date: billData.date,
      totalCost: billData.totalCost + price,
      userId: billData.userId,
    );
    notifyListeners();
  }

  double getBillTotalAmount(String billId) {
    return _bills.firstWhere((billData) => billData.id == billId).totalCost;
  }

  void addNewBill(Bill newBill) {
    int index = _bills.indexWhere((billData) => billData.id == newBill.id);
    _bills[index] = newBill;
    notifyListeners();
  }

  void calcelBill(String billId) {
    Bill newBill = _bills.firstWhere((billData) => billData.id == billId);
    int billIndex = _bills.indexWhere((billData) => billData.id == billId);
    newBill = Bill(
      id: newBill.id,
      date: newBill.date,
      totalCost: newBill.totalCost,
      userId: newBill.userId,
      museumTime: newBill.museumTime,
      isCanceled: true,
    );
    _bills[billIndex] = newBill;
    notifyListeners();
  }

  void deleteBill(String billId) {
    _bills.removeWhere((billData) => billData.id == billId);
    notifyListeners();
  }

  List getBillIds(String userId) {
    var billIds = [];
    List<Bill> allUsersBills =
        _bills.where((billData) => billData.userId == userId).toList();
    for (var i = 0; i < allUsersBills.length; i++) {
      if (allUsersBills[i].date.compareTo(DateTime.now()) > 0) {
        billIds.add(allUsersBills[i].id);
      }
    }
    return billIds;
  }
}
