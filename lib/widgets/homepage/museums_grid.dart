import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/museums.dart';
import './museum_grid_item.dart';
import '../../models/museum.dart';


class MuseumsGrid extends StatelessWidget {
  List<Museum> museums;
  MuseumsGrid(this.museums);
  @override
  Widget build(BuildContext context) {
     //access to museums data
    return museums.isNotEmpty ? GridView.builder(
      shrinkWrap: true, //remove this if search is fixed
      physics: const NeverScrollableScrollPhysics(),//remove this if search is fixed
      padding: const EdgeInsets.all(10),
      itemCount: museums.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: museums[i],
        child: MuseumGridItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
    ) : Padding(padding: EdgeInsets.only(top:20),child: Image.asset('assets/images/NoArtworks.png',fit: BoxFit.fill,));
  }
}
