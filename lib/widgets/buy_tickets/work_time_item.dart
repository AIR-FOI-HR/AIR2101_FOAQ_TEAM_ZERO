import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bills.dart';

class WorkTimeItem extends StatefulWidget {
  var workTime;

  WorkTimeItem(this.workTime);

  @override
  _WorkTimeItemState createState() => _WorkTimeItemState();
}

class _WorkTimeItemState extends State<WorkTimeItem> {
  @override
  Widget build(BuildContext context) {
    String openingSection = widget.workTime['openingTime'].format(context);
    String closingSection = widget.workTime['closingTime'].format(context);

    final color = Theme.of(context);
    final billProv = Provider.of<Bills>(context);
    final billSelectedTime = billProv.getSelectedTime();
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: (billSelectedTime == null) ||
                  (billSelectedTime != widget.workTime['openingTime'])
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).highlightColor,
          boxShadow: kElevationToShadow[6],
        ),
        child: FlatButton(
          child: Text(
            '$openingSection - $closingSection',
            style: color.textTheme.headline4,
          ),
          onPressed: () {
            setState(() {
              billProv.setSelectedTime(widget.workTime['openingTime']);
            });
          },
        ),
      ),
    );
  }
}
