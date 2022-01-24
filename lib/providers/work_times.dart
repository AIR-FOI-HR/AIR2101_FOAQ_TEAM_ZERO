// ignore_for_file: prefer_final_fields

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/work_time.dart';

class WorkTimes with ChangeNotifier {
  List<WorkTime> _workTimes = [
    WorkTime(
      id: '0',
      day: 'Monday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '1',
      day: 'Tuesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '2',
      day: 'Wednesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '3',
      day: 'Thursday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '4',
      day: 'Friday',
      museumId: '1',
    ),
    WorkTime(
      id: '5',
      day: 'Saturday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '6',
      day: 'Sunday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '1',
    ),
  ];

  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<WorkTime> getWorkTime(String id) {
    final workTimeList = _workTimes.firstWhere(
        (workTimeData) => workTimeData.museumId == id,
        orElse: () => null);
    if (workTimeList == null) {
      int theLastId = _workTimes.length;
      for (int i = 0; i < 7; i++) {
        final newWorkTime = WorkTime(
          id: (theLastId + i).toString(),
          day: days[i],
          museumId: id,
        );
        _workTimes.add(newWorkTime);
      }
    }
    return _workTimes
        .where((workTimeData) => workTimeData.museumId == id)
        .toList();
  }
}
