import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/museum.dart';
import '../../providers/work_times.dart';
import '../ticket_configuration/elevated_button_settings.dart';

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
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  'categories categories categories categories categories categories ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_basket_outlined,
                    size: 30,
                    color: color.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
