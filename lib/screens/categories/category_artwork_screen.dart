import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/categories/category_artwork_grid.dart';
import '../../widgets/categories/save_button.dart';
import '../../widgets/categories/add_new_category_button.dart';

class CategoryArtworkScreen extends StatelessWidget {
  static const routeName = '/categoryArtwork';

  @override
  Widget build(BuildContext context) {
    final int privileges = 1;
    final appBarProperty =
        appBar('Categories', context, Theme.of(context).primaryColor);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.87,
              child: CategoryArtworkGrid(),
            ),
            Divider(
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
            privileges == 1 ? AddNewCategoryButton() : SaveButton(),
          ],
        ),
      ),
    );
  }
}
