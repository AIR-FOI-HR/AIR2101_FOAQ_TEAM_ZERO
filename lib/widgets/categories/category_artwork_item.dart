import 'package:flutter/material.dart';
import '../../providers/categories.dart';
import 'package:provider/provider.dart';

class CategoryArtworkItem extends StatefulWidget {
  final String id;
  final String name;

  CategoryArtworkItem(this.id, this.name);
  @override
  State<CategoryArtworkItem> createState() => _CategoryArtworkItemState();
}

class _CategoryArtworkItemState extends State<CategoryArtworkItem> {
  var _showSelectedCategory = false;
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _showSelectedCategory
            ? Theme.of(context).highlightColor
            : Theme.of(context).primaryColorLight,
        boxShadow: kElevationToShadow[6],
      ),
      child: FlatButton(
        child: Text(
          widget.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        onPressed: () {
          setState(() {
            if (_showSelectedCategory) {
              categoryData.removeSelectedCategory(widget.id);
            } else {
              categoryData.selectCategory(widget.id, widget.name);
            }
            _showSelectedCategory = !_showSelectedCategory;
          });
        },
      ),
    );
  }
}
