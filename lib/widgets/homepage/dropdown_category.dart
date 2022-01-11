import 'package:flutter/material.dart';
import '../../providers/categories.dart';
import 'package:provider/provider.dart';

class DropDownCategory extends StatefulWidget {

  final ValueChanged<String> changedCategory;

  const DropDownCategory(this.changedCategory);

  @override
  _DropDownCategoryState createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  var selectedCategory = 'c0';

  
  @override
  Widget build(BuildContext context) {
    final selectedCategoryList =
        Provider.of<Categories>(context).itemsSelectetCategory;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 0, 0),
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          ),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          child: DropdownButton(
            dropdownColor: Theme.of(context).primaryColorLight,
            value: selectedCategory,
            onChanged: (value) {
              widget.changedCategory(value);
              setState(() {
                selectedCategory = value;
              });
            },
            items: selectedCategoryList.map((items) {
              return DropdownMenuItem(
                value: items.id,
                child: Text(
                  items.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      );
}
