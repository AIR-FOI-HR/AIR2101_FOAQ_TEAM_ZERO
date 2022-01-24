// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/work_time.dart';

class WorkTimes with ChangeNotifier {
  List<WorkTime> _workTimes = [
    WorkTime(
      id: '1',
      day: 'Monday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '2',
      day: 'Tuesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '3',
      day: 'Wednesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '4',
      day: 'Thursday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '5',
      day: 'Friday',
      museumId: '1',
    ),
    WorkTime(
      id: '6',
      day: 'Saturday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '7',
      day: 'Nedelja',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '1',
    ),
    WorkTime(
      id: '8',
      day: 'Monday',
      museumId: '2',
    ),
    WorkTime(
      id: '9',
      day: 'Tuesday',
      museumId: '2',
    ),
    WorkTime(
      id: '10',
      day: 'Wednesday',
      museumId: '2',
    ),
    WorkTime(
      id: '11',
      day: 'Thursday',
      museumId: '2',
    ),
    WorkTime(
      id: '12',
      day: 'Friday',
      museumId: '1',
    ),
    WorkTime(
      id: '13',
      day: 'Saturday',
      museumId: '2',
    ),
    WorkTime(
      id: '14',
      day: 'Nedelja',
      museumId: '2',
    ),
  ];

  List<WorkTime> getWorkTime(String id) {
    return _workTimes
        .where((workTimeData) => workTimeData.museumId == id)
        .toList();
  }
}
