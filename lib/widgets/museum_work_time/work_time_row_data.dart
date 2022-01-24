import 'package:flutter/material.dart';

class WorkTimeRowData extends StatelessWidget {
  final String day;
  final String timeFrom;
  final String timeTo;

  WorkTimeRowData(this.day, this.timeFrom, this.timeTo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            day,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            timeFrom,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            timeTo,
            style: const TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
