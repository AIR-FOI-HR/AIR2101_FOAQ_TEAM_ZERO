import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bill {
  final String id;
  final DateTime date;
  final String qrCode;
  final double totalCost;
  final String userId;
  final bool isCanceled;
  final TimeOfDay museumTime;

  Bill({
    @required this.id,
    @required this.date,
    this.qrCode,
    @required this.totalCost,
    @required this.userId,
    this.isCanceled = false,
    this.museumTime,
  });
}
