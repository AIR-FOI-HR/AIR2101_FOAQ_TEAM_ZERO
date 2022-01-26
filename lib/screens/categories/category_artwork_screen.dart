import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/categories/showing/category_artwork_grid.dart';
import '../../widgets/categories/showing/save_button.dart';
import '../../widgets/categories/editing/add_new_category_button.dart';
import '../../providers/users.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';


//tomekovo
class CategoryArtworkScreen extends StatelessWidget {
  static const routeName = '/categoryArtwork';

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    const int privileges = 0;
    final appBarProperty =
        appBar('Categories', context, Theme.of(context).primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
