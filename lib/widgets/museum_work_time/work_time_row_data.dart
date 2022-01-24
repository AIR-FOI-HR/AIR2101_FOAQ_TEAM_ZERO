import 'package:flutter/material.dart';

import '../../screens/single_musem_configuration/museum_work_time_crud_screen.dart';
import '../ticket_configuration/elevated_button_settings.dart';

class WorkTimeRowData extends StatelessWidget {
  final String workTimeId;
  final String day;
  final String timeFrom;
  final String timeTo;
  final bool edit;

  WorkTimeRowData(
      this.workTimeId, this.day, this.timeFrom, this.timeTo, this.edit);

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
        ),
        edit
            ? Expanded(
                flex: 1,
                child: SizedBox(
                  height: 20,
                  child: IconButton(
                    highlightColor: Theme.of(context).primaryColorLight,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          MuseumWorkTimeCrudScreen.routeName,
                          arguments: workTimeId);
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ),
              )
            : const Expanded(
                flex: 1,
                child: Center(
                  child: Text('Edit'),
                ),
              )
      ],
    );
  }
}
