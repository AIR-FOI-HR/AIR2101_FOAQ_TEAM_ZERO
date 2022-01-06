// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/foundation.dart';
import '../models/category_artwork.dart';

class Categories with ChangeNotifier {
  List<CategoryArtwork> _items = [
    CategoryArtwork(id: 'c1', name: 'Early american art'),
    CategoryArtwork(id: 'c2', name: '19th centurey'),
    CategoryArtwork(id: 'c3', name: '20th century'),
    CategoryArtwork(id: 'c4', name: 'Contemporary art'),
    CategoryArtwork(id: 'c5', name: 'Photography'),
    CategoryArtwork(id: 'c6', name: 'Sculpture'),
    CategoryArtwork(id: 'c7', name: 'Works on paper'),
    CategoryArtwork(id: 'c8', name: 'Mixed Media'),
    CategoryArtwork(id: 'c9', name: 'Relief'),
    CategoryArtwork(id: 'c10', name: 'Print'),
    CategoryArtwork(id: 'c11', name: 'Painting'),
    CategoryArtwork(id: 'c12', name: 'Miniature'),
    CategoryArtwork(id: 'c13', name: 'Medal'),
    CategoryArtwork(id: 'c14', name: 'Assemblage'),
    CategoryArtwork(id: 'c15', name: 'Book'),
    CategoryArtwork(id: 'c16', name: 'Decorative Arts'),
    CategoryArtwork(id: 'c17', name: 'Drawing'),
    CategoryArtwork(id: 'c18', name: 'Fiber'),
    CategoryArtwork(id: 'c19', name: 'Furniture'),
    CategoryArtwork(id: 'c20', name: 'Glass'),
    CategoryArtwork(id: 'c21', name: 'Graphic Arts'),
    CategoryArtwork(id: 'c22', name: 'Block/plate/stencil'),
    CategoryArtwork(id: 'c23', name: 'Archival Material'),
    CategoryArtwork(id: 'c24', name: 'Graphic Arts'),
    CategoryArtwork(id: 'c25', name: 'Installation Art'),
    CategoryArtwork(id: 'c26', name: 'Maquette'),
  ];
  List<CategoryArtwork> _selectedCategories = [];

  List<CategoryArtwork> get items {
    return [..._items];
  }

  List<CategoryArtwork> get itemsSelectetCategory {
    return [..._selectedCategories];
  }

  void selectCategory(String id, String name) {
    _selectedCategories.insert(
      0,
      CategoryArtwork(id: id, name: name),
    );
  }

  void removeSelectedCategory(String id) {
    _selectedCategories.removeWhere((categ) => categ.id == id);
  }
}
