import 'package:flutter/material.dart';

class MuseumColumnData extends StatelessWidget {
  String title;

  MuseumColumnData(this.title);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: textStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
