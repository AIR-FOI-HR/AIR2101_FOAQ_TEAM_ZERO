// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../models/bill.dart';

class Bills with ChangeNotifier {
  List<Bill> _bills = [
    Bill(
      id: '1',
      date: DateTime.parse('2022-01-14 20:18:04Z'),
      totalCost: 20.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 14, minute: 0),
    ),
    Bill(
      id: '2',
      date: DateTime.parse('2022-01-16 12:38:04Z'),
      totalCost: 25.00,
      userId: 'u1',
      museumTime: const TimeOfDay(hour: 10, minute: 0),
    ),
    Bill(
      id: '3',
      date: DateTime.parse('2022-01-21 09:30:09Z'),
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

  void addNewBill(Bill bill) {
    final newBill = Bill(
      id: (_bills.length + 1).toString(),
      date: bill.date,
      totalCost: bill.totalCost,
      userId: bill.userId,
    );
    _bills.add(newBill);
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
}
