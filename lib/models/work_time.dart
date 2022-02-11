import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkTime with ChangeNotifier {
  final String id;
  final String day;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;
  final String museumId;

  WorkTime({
    this.id,
    @required this.day,
    this.timeFrom,
    this.timeTo,
    @required this.museumId,
  });

  static WorkTime fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return WorkTime(
      id: snap.id,
      museumId: snapshot["museum"],
      day: snapshot["day"],
      timeFrom:
          TimeOfDay(hour: snapshot["hourFrom"], minute: snapshot["minuteFrom"]),
      timeTo: TimeOfDay(hour: snapshot["hourTo"], minute: snapshot["minuteTo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "museum": museumId,
        "day": day,
        "hourFrom": timeFrom.hour,
        "minuteFrom": timeFrom.minute,
        "hourTo": timeTo.hour,
        "minuteTo": timeTo.minute,
      };
}
