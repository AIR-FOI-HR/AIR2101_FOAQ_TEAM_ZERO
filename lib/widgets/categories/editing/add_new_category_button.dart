import 'package:flutter/material.dart';
import '../../../screens/categories/category_artwork_editing_screen.dart';

class AddNewCategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'Add a new category',
        style: Theme.of(context).textTheme.headline3,
      ),
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).highlightColor,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(CategoryArtworkEditingScreen.routeName, arguments: null);
      },
    );
  }
}
