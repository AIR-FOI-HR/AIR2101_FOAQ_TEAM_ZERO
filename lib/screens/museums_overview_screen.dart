import 'package:flutter/material.dart';
import '../widgets/homepage/museums_grid.dart';
import '../widgets/homepage/search_bar.dart';
import '../widgets/homepage/dropdown_category.dart';
import '../widgets/main_menu_drawer.dart';
import '../widgets/app_bar.dart';

class MuseumsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Museum app', context, Theme.of(context).primaryColor),
      body: SingleChildScrollView( //remove this SingleChildScroolView if search is fixed
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownCategory(),
                SearchBar(),
              ],
            ),
             MuseumsGrid(), //wrap with flexible if search is fixed
          ],
        ),
      ),
      drawer: MainMenuDrawer(),
    );
  }
}
