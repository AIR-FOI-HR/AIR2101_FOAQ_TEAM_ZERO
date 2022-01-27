// ignore_for_file: unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/category_artwork.dart';
import 'package:flutter/foundation.dart';

class Categories with ChangeNotifier {
  List<CategoryArtwork> _categories = [];

  List<CategoryArtwork> _selectedCategories = [
    CategoryArtwork(id: 'c0', name: 'All Museums')
  ];

  Future<void> fetchCategories() async {
    List<CategoryArtwork> loadedCategories = [];
    _categories.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      loadedCategories.add(CategoryArtwork(
        id: doc.id,
        name: data["name"],
      ));
      print(doc.id);
      print(data["name"]);
    }
    _categories = loadedCategories;
    notifyListeners();
  }

  List<CategoryArtwork> get items {
    print(_categories.length);
    return [..._categories];
  }

  List<CategoryArtwork> get itemsSelectetCategory {
    return [..._selectedCategories];
  }

  void selectCategory(String id, String name) {
    _selectedCategories.insert(
      _selectedCategories.length,
      CategoryArtwork(id: id, name: name),
    );
  }

  void removeSelectedCategory(String id) {
    _selectedCategories.removeWhere((categ) => categ.id == id);
  }

  void clearSelectedCategoryList() {
    _selectedCategories = [
      CategoryArtwork(id: 'c0', name: 'All Museums'),
    ];
    notifyListeners();
  }

  void deleteCategoryById(String id) {
    _categories.removeWhere((cateData) => cateData.id == id);
  }

  void addCategory(String id, String name) {
    var newId = (_categories.length + 1).toString();
    if (id != null) {
      deleteCategoryById(id);
      newId = id;
    }
    _categories.insert(0, CategoryArtwork(id: newId, name: name));
  }

  CategoryArtwork findById(String id) {
    if (id == null) return null;
    return _categories.firstWhere((catData) => catData.id == id,
        orElse: () => null);
  }
}
