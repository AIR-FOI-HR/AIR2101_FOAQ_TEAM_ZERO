import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/categories/category_artwork_grid.dart';

class CategoryArtworkScreen extends StatelessWidget {
  static const routeName = '/categoryArtwork';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Categories', context, Theme.of(context).primaryColor),
      drawer: MainMenuDrawer(),
      body: CategoryArtworkGrid(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).highlightColor,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        elevation: 5,
        child: Icon(
          Icons.save,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
