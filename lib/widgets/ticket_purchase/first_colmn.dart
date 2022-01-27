import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/museum.dart';
import '../../providers/work_times.dart';

class FirstColumn extends StatelessWidget {
  final Museum museumData;

  FirstColumn(this.museumData);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: Text(
              museumData.name,
              style: color.textTheme.headline5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            museumData.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            Provider.of<WorkTimes>(context)
                .getTheWorkTime(museumData.id, context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          const Text(
            'Category',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
