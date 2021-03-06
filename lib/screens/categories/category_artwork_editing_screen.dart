import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/category_artwork.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../providers/categories.dart';
import './category_artwork_screen.dart';
import '../../widgets/categories/editing/crud_elevated_button.dart';

class CategoryArtworkEditingScreen extends StatelessWidget {
  static const routeName = '/categoryArtworkEditing';

  TextEditingController categoryNameControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    final categoryItemId = ModalRoute.of(context).settings.arguments as String;
    final appBarProperty =
        appBar('Categories', context, Theme.of(context).primaryColor, appUser);
    final categoryItems = Provider.of<Categories>(context);
    final categoryItemData = categoryItems.findById(categoryItemId);
    final mediaQuery = MediaQuery.of(context);

    void saveCategory() {
      CategoryArtwork newCategory = CategoryArtwork(
        id: categoryItemId,
        name: categoryNameControler.text,
      );

      if (categoryItemId == null) {
        DBCaller.addCategory(newCategory)
            .then((_) => Navigator.of(context).pop());
      } else {
        DBCaller.updateCategory(newCategory)
            .then((_) => Navigator.of(context).pop());
      }
    }

    void deleteCategory(String categoryId) {
      DBCaller.deleteCategory(categoryId).then((_) => Navigator.of(context)
          .pushReplacementNamed(CategoryArtworkScreen.routeName));
    }

    return Scaffold(
      appBar: appBarProperty,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.all(10),
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
                const SizedBox(
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
                  //autofocus: true,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CrudElevatedButton(
                'Cancel',
                () => Navigator.of(context).pop(),
              ),
              if (categoryItemId != null)
                CrudElevatedButton(
                  'Delete',
                  () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text(
                        'Are you sure?',
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      ),
                      content: Container(
                        height: 70,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Do you want to remove category: '),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${categoryItemData.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'No',
                            style: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                            deleteCategory(categoryItemData.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              CrudElevatedButton(
                'Save',
                () => saveCategory(),
              )
            ],
          )
        ],
      ),
    );
  }
}
