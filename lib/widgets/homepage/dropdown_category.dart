import 'package:flutter/material.dart';

class DropDownCategory extends StatefulWidget {
  @override
  _DropDownCategoryState createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  final mockCategories = [
    'Everything',
    'Art',
    'Old guns',
    'Swords',
    'History',
    'Gladiators and'
  ];
  String selectedCategory = 'Everything';

  @override
  Widget build(BuildContext context) {
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
            dropdownColor: Theme.of(context).accentColor,
            onChanged: (value) {
              selectedCategory = value;
              setState(() {});
            },
            value: selectedCategory,
            items: mockCategories.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
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
          style: TextStyle(fontSize: 14,color: Colors.white),
        ),
      );
}
