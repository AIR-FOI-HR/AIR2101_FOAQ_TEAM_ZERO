import 'package:flutter/material.dart';

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
    return FittedBox(
      fit: BoxFit.contain,
      child: Text('$openingSection - $closingSection'),
    );
  }
}
