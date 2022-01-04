import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/museums.dart';
import './museum_grid_item.dart';

class MuseumsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final museumsData =
        Provider.of<Museums>(context).getMuseums; //access to museums data
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: museumsData.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: museumsData[i],
        child: MuseumGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2 / 1,
        mainAxisSpacing: 10,
      ),
    );
  }
}
