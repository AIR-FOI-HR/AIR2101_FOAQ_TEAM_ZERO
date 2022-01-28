import 'package:flutter/cupertino.dart';

class Bill {
  final String id;
  final DateTime date;
  final String qrCode;
  final double totalCost;
  final String userId;

  Bill({
    @required this.id,
    @required this.date,
    this.qrCode,
    @required this.totalCost,
    @required this.userId,
  });
}
