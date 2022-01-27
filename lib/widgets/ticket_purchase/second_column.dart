import 'package:flutter/material.dart';
import '../../models/museum.dart';

class SecondColumn extends StatelessWidget {
  final Museum museumData;

  SecondColumn(this.museumData);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Text(
            'Capacity 50',
            style: color.textTheme.headline5,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
