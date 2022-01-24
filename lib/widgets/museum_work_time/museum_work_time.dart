import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/work_times.dart';
import './work_time_row_data.dart';

class MuseumWorkTime extends StatelessWidget {
  final String museumId;

  MuseumWorkTime(this.museumId);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final workTimeProv = Provider.of<WorkTimes>(context).getWorkTime(museumId);

    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work time',
              style: color.textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  WorkTimeRowData('0', 'Day', 'From', 'To', false),
                  SizedBox(
                    height: constraints.maxHeight * 0.75,
                    child: ListView.builder(
                      itemCount: workTimeProv.length,
                      itemBuilder: (_, i) => Column(
                        children: [
                          const Divider(),
                          WorkTimeRowData(
                            workTimeProv[i].id,
                            workTimeProv[i].day,
                            workTimeProv[i].timeFrom == null
                                ? 'Closed'
                                : workTimeProv[i].timeFrom.format(context),
                            workTimeProv[i].timeTo == null
                                ? 'Closed'
                                : workTimeProv[i].timeTo.format(context),
                            true,
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
