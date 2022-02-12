import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bill with ChangeNotifier {
  final String id;
  final DateTime date;
  final String qrCode;
  final double totalCost;
  final String userId;
  final bool isCanceled;
  final TimeOfDay museumTime;

  Bill({
    this.id,
    @required this.date,
    this.qrCode,
    @required this.totalCost,
    @required this.userId,
    this.isCanceled = false,
    this.museumTime,
  });

  static Bill fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Bill(
        id: snap.id,
        date: snapshot["date"],
        totalCost: snapshot["totalCost"],
        userId: snapshot["user"],
        isCanceled: snapshot["isCanceled"],
        museumTime: TimeOfDay(
            hour: snapshot["museumTimeHour"],
            minute: snapshot["museumTimeMinute"]),
        qrCode: snapshot["qrCode"]);
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "totalCost": totalCost,
        "user": userId,
        "isCanceled": isCanceled,
        "qrCode": qrCode,
        "museumTimeHour": museumTime.hour,
        "museumTimeMinute": museumTime.minute
      };
}
