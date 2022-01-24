import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorkTime {
  final String id;
  final String day;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;
  final String museumId;

  WorkTime({
    @required this.id,
    @required this.day,
    this.timeFrom,
    this.timeTo,
    @required this.museumId,
  });
}
