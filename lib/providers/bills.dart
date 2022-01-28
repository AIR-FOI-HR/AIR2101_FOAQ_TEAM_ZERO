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
    ),
    Bill(
      id: '2',
      date: DateTime.parse('2022-01-16 12:38:04Z'),
      totalCost: 25.00,
      userId: 'u1',
    ),
    Bill(
      id: '3',
      date: DateTime.parse('2022-01-21 09:30:09Z'),
      totalCost: 5.00,
      userId: 'u1',
    ),
  ];

  List<Bill> getBills(String userId) {
    return _bills.where((BillData) => BillData.userId == userId).toList();
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
}
