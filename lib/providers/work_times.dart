// ignore_for_file: prefer_final_fields, avoid_init_to_null

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import '../models/work_time.dart';

class WorkTimes with ChangeNotifier {
  List<WorkTime> _workTimes = [
    // WorkTime(
    //   id: '0',
    //   day: 'Monday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '1',
    //   day: 'Tuesday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '2',
    //   day: 'Wednesday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '3',
    //   day: 'Thursday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '4',
    //   day: 'Friday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '5',
    //   day: 'Saturday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '6',
    //   day: 'Sunday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '1',
    // ),
    // WorkTime(
    //   id: '0',
    //   day: 'Monday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '2',
    //   day: 'Tuesday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '2',
    //   day: 'Wednesday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '3',
    //   day: 'Thursday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 16, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '4',
    //   day: 'Friday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '5',
    //   day: 'Saturday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '6',
    //   day: 'Sunday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '2',
    // ),
    // WorkTime(
    //   id: '7',
    //   day: 'Thursday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '3',
    // ),
    // WorkTime(
    //   id: '8',
    //   day: 'Thursday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '4',
    // ),
    // WorkTime(
    //   id: '9',
    //   day: 'Friday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '3',
    // ),
    // WorkTime(
    //   id: '10',
    //   day: 'Friday',
    //   timeFrom: const TimeOfDay(hour: 8, minute: 0),
    //   timeTo: const TimeOfDay(hour: 20, minute: 0),
    //   museumId: '4',
    // ),
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

  Future<void> fetchWorkTimes(String museumId) async {
    List<WorkTime> loadedWorktimes = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("worktimes").get();
    for (var doc in querySnapshot.docs) {
      loadedWorktimes.add(WorkTime.fromSnap(doc));
    }
    if (museumId != "") {
      final workTimeExist = loadedWorktimes.firstWhere(
          (element) => element.museumId == museumId,
          orElse: () => null);
      if (workTimeExist == null) {
        for (int i = 0; i < 7; i++) {
          final newWorkTime = WorkTime(
            day: days[i],
            museumId: museumId,
          );
          await DBCaller.addWorkTime(newWorkTime);
        }
      }
    }
    loadedWorktimes.clear();
    querySnapshot =
        await FirebaseFirestore.instance.collection("worktimes").get();
    for (var doc in querySnapshot.docs) {
      loadedWorktimes.add(WorkTime.fromSnap(doc));
    }
    _workTimes.clear();
    _workTimes = loadedWorktimes;
  }

  List<WorkTime> getWorkTime(String museumId) {
    return _workTimes
        .where((workTimeData) => workTimeData.museumId == museumId)
        .toList();
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

  TimeOfDay getTimeOfDay(int time) {
    int timeHours = time ~/ 60;
    int timeMinuts = time - timeHours * 60;
    return TimeOfDay(hour: timeHours, minute: timeMinuts);
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
