import 'package:flutter/material.dart';
import '../widgets/homepage/museums_grid.dart';
import '../widgets/homepage/search_bar.dart';
import '../widgets/homepage/dropdown_category.dart';
import '../widgets/main_menu_drawer.dart';

class MuseumsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Museum app'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
