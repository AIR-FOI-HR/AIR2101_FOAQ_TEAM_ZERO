// ignore_for_file: prefer_final_fields, avoid_init_to_null

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
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
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
    WorkTime(
      id: '0',
      day: 'Monday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '2',
      day: 'Tuesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '2',
      day: 'Wednesday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '3',
      day: 'Thursday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 16, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '4',
      day: 'Friday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '5',
      day: 'Saturday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '6',
      day: 'Sunday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '2',
    ),
    WorkTime(
      id: '7',
      day: 'Thursday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '3',
    ),
    WorkTime(
      id: '8',
      day: 'Thursday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '4',
    ),
    WorkTime(
      id: '9',
      day: 'Friday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '3',
    ),
    WorkTime(
      id: '10',
      day: 'Friday',
      timeFrom: const TimeOfDay(hour: 8, minute: 0),
      timeTo: const TimeOfDay(hour: 20, minute: 0),
      museumId: '4',
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

  List<WorkTime> getWorkTime(String museumId) {
    final workTimeList = _workTimes.firstWhere(
        (workTimeData) => workTimeData.museumId == museumId,
        orElse: () => null);
    if (workTimeList == null) {
      int theLastId = _workTimes.length;
      for (int i = 0; i < 7; i++) {
        final newWorkTime = WorkTime(
          id: (theLastId + i).toString(),
          day: days[i],
          museumId: museumId,
        );
        _workTimes.add(newWorkTime);
      }
    }
    return _workTimes
        .where((workTimeData) => workTimeData.museumId == museumId)
        .toList();
  }

  WorkTime todayWorkTimeData(String museumId) {
    List<WorkTime> museumWorkTime = _workTimes
        .where((workTimeData) => workTimeData.museumId == museumId)
        .toList();
    String todayDay = getDayName(null);
    return museumWorkTime.firstWhere(
      (museumWorkTimeData) => museumWorkTimeData.day == todayDay,
      orElse: () => null,
    );
  }

  bool ifTheWorkTimeExist(String museumId) {
    WorkTime todayWorkTime = todayWorkTimeData(museumId);

    if (todayWorkTime != null &&
        todayWorkTime.timeFrom != null &&
        todayWorkTime.timeTo != null) {
      return true;
    }
    return false;
  }

  String getDayName(String dateTime) {
    DateTime now;
    if (dateTime == null) {
      now = DateTime.now();
    } else {
      now = DateTime.parse(dateTime);
    }

    String formatter = DateFormat('EEEE').format(now);
    return formatter;
  }

  List getWorkTimeSections(
    WorkTime museumWorkTimeData,
    int tourDuration,
    BuildContext context,
  ) {
    if (museumWorkTimeData.timeFrom != null &&
        museumWorkTimeData.timeTo != null) {
      int closingMinuts = museumWorkTimeData.timeTo.hour * 60 +
          museumWorkTimeData.timeTo.minute;
      int openingMinuts = museumWorkTimeData.timeFrom.hour * 60 +
          museumWorkTimeData.timeFrom.minute;
      int sections = (closingMinuts - openingMinuts) ~/ tourDuration;

      var workTimeSections = List(sections);

      for (int i = 0; i < sections; i++) {
        int time = openingMinuts + i * tourDuration;
        TimeOfDay openingTime = getTimeOfDay(time);
        TimeOfDay closingTime = getTimeOfDay(time + tourDuration);
        workTimeSections[i] = {
          'openingTime': openingTime,
          'closingTime': closingTime
        };
      }
      return workTimeSections;
    } else {
      return [];
    }
  }

  TimeOfDay getTimeOfDay(int time) {
    int timeHours = time ~/ 60;
    int timeMinuts = time - timeHours * 60;
    return TimeOfDay(hour: timeHours, minute: timeMinuts);
  }

  WorkTime getTheWorkTimeOfSelectedDay(String museumId, DateTime dateTime) {
    List<WorkTime> museumWorkTime = _workTimes
        .where((workTimeData) => workTimeData.museumId == museumId)
        .toList();
    String todayDay = getDayName(dateTime.toString());
    return museumWorkTime.firstWhere(
      (museumWorkTimeData) => museumWorkTimeData.day == todayDay,
      orElse: () => null,
    );
  }

  String getTheWorkTime(String museumId, BuildContext context) {
    WorkTime todayWorkTime = todayWorkTimeData(museumId);
    return '${todayWorkTime.timeFrom.format(context)} - ${todayWorkTime.timeTo.format(context)}';
  }

  WorkTime findWorkTimeById(String id) {
    return _workTimes.firstWhere((workTimeData) => workTimeData.id == id);
  }

  void updateWorkTime(WorkTime newWorkTime) {
    final workTimeIndex = _workTimes
        .indexWhere((workTimeData) => workTimeData.id == newWorkTime.id);
    if (workTimeIndex >= 0) {
      _workTimes[workTimeIndex] = newWorkTime;
      notifyListeners();
    }
  }
}
