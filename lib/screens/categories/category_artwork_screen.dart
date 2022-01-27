import 'package:flutter/material.dart';
import 'package:museum_app/models/category_artwork.dart';
import 'package:museum_app/providers/categories.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/categories/showing/category_artwork_grid.dart';
import '../../widgets/categories/showing/save_button.dart';
import '../../widgets/categories/editing/add_new_category_button.dart';
import '../../providers/users.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';

//tomekovo
class CategoryArtworkScreen extends StatefulWidget {
  static const routeName = '/categoryArtwork';

  @override
  State<CategoryArtworkScreen> createState() => _CategoryArtworkScreenState();
}

class _CategoryArtworkScreenState extends State<CategoryArtworkScreen> {

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    Future<void> _fetchCategories() async {
      await Provider.of<Categories>(context, listen: false).fetchCategories();
    }

    final appBarProperty =
        appBar('Categories', context, Theme.of(context).primaryColor, appUser);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Container(
        child: FutureBuilder(
          future: _fetchCategories(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
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
                          appUser == null
                              ? SaveButton()
                              : int.parse(appUser.userRole) > 2
                                  ? AddNewCategoryButton()
                                  : SaveButton(),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
