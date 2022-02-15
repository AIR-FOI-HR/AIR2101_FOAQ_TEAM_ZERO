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
      timeFrom: snapshot["hourFrom"] == -1
          ? null
          : TimeOfDay(
              hour: snapshot["hourFrom"], minute: snapshot["minuteFrom"]),
      timeTo: snapshot["hourTo"] == -1
          ? null
          : TimeOfDay(hour: snapshot["hourTo"], minute: snapshot["minuteTo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "museum": museumId,
        "day": day,
        "hourFrom": timeFrom == null ? -1 : timeFrom.hour,
        "minuteFrom": timeFrom == null ? -1 : timeFrom.minute,
        "hourTo": timeTo == null ? -1 : timeTo.hour,
        "minuteTo": timeTo == null ? -1 : timeTo.minute,
      };
}
