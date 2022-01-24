import 'package:flutter/material.dart';
import 'package:museum_app/providers/work_times.dart';
import 'package:provider/provider.dart';

class MuseumWorkTime extends StatelessWidget {
  final String museumId;

  MuseumWorkTime(this.museumId);

  Widget rowData(String day, String timeFrom, String timeTo) {
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

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final workTimeProv = Provider.of<WorkTimes>(context).getWorkTime(museumId);

    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Work time',
              style: color.textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  rowData('Day', 'From', 'To'),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: ListView.builder(
                      itemCount: workTimeProv.length,
                      itemBuilder: (_, i) => Column(
                        children: [
                          Divider(),
                          rowData(
                            workTimeProv[i].day,
                            workTimeProv[i].timeFrom == null
                                ? 'Closed'
                                : workTimeProv[i].timeFrom.format(context),
                            workTimeProv[i].timeTo == null
                                ? 'Closed'
                                : workTimeProv[i].timeTo.format(context),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
