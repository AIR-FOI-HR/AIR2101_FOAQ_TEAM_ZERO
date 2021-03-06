import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bill with ChangeNotifier {
  final String id;
  final DateTime date;
  bool isUsed;
  final double totalCost;
  final String userId;
  bool isCanceled;
  final TimeOfDay museumTime;
  final DateTime purchaseDateTime;

  Bill({
    this.id,
    @required this.date,
    this.isUsed,
    @required this.totalCost,
    @required this.userId,
    this.isCanceled = false,
    this.museumTime,
    this.purchaseDateTime,
  });

  static Bill fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Bill(
        id: snap.id,
        date: DateTime.parse(snapshot["date"].toDate().toString()),
        totalCost: snapshot["totalCost"],
        userId: snapshot["user"],
        isCanceled: snapshot["isCanceled"],
        museumTime: TimeOfDay(
            hour: snapshot["museumTimeHour"],
            minute: snapshot["museumTimeMinute"]),
        isUsed: snapshot["isUsed"],
        purchaseDateTime:
            DateTime.parse(snapshot["purchaseDateTime"].toDate().toString()));
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "totalCost": totalCost,
        "user": userId,
        "isCanceled": isCanceled,
        "isUsed": isUsed,
        "museumTimeHour": museumTime.hour,
        "museumTimeMinute": museumTime.minute,
        "purchaseDateTime": purchaseDateTime
      };
}
