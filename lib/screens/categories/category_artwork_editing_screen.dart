import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../providers/categories.dart';
import './category_artwork_screen.dart';

class CategoryArtworkEditingScreen extends StatelessWidget {
  Widget elevatedButton(
      BuildContext context, String title, Function onPressConfig) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).highlightColor,
      ),
      onPressed: onPressConfig,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  static const routeName = '/categoryArtworkEditing';

  TextEditingController categoryNameControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryItemId = ModalRoute.of(context).settings.arguments as String;
    final appBarProperty =
        appBar('Categories', context, Theme.of(context).primaryColor);
    final categoryItems = Provider.of<Categories>(context);
    final categoryItemData = categoryItems.findById(categoryItemId);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBarProperty,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: (mediaQuery.size.height -
                    appBarProperty.preferredSize.height -
                    mediaQuery.padding.top) *
                0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    categoryItemData == null
                        ? 'Add a category name:'
                        : 'Selected category: ${categoryItemData.name}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: categoryNameControler,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the name',
                  ),
                  autofocus: true,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(context, 'Cancel', () {
                Navigator.of(context).pop();
              }),
              if (categoryItemId != null)
                elevatedButton(context, 'Delete', () {
                  categoryItems.deleteCategoryById(categoryItemId);
                  Navigator.of(context)
                      .pushReplacementNamed(CategoryArtworkScreen.routeName);
                }),
              elevatedButton(context, categoryItemId == null ? 'Add' : 'Save',
                  () {
                categoryItems.addCategory(
                    categoryItemId, categoryNameControler.text);
                Navigator.of(context)
                    .pushReplacementNamed(CategoryArtworkScreen.routeName);
              })
            ],
          )
        ],
      ),
    );
  }
}
