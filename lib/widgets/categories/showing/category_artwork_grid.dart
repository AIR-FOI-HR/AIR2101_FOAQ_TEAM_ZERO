// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';
import '../../../providers/categories.dart';
import './category_artwork_item.dart';

class CategoryArtworkGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);

    User appUser = Provider.of<Users>(context, listen: false).getUser();
    int userRole = appUser == null ? 0 : int.parse(appUser.userRole);
    final categories = categoryData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: categories.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: categories[i],
        child: CategoryArtworkItem(
          categories[i].id,
          categories[i].name,
          userRole,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
