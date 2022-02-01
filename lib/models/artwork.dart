import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Artwork with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String author;
  final String museum;
  final String category;
  bool isFavorite;

  Artwork(
      {this.id,
      @required this.name,
      this.imageUrl,
      this.description,
      this.author,
      @required this.museum,
      @required this.category,
      this.isFavorite = false});

  static Artwork fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, String>;
    return Artwork(
      id: snap.id,
      category: snap["category"],
      museum: snap["museum"],
      name: snap["name"],
      author: snap["author"],
      description: snap["description"],
      imageUrl: snap["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "category": category,
        "museum": museum,
        "name": name,
        "author": author,
        "description": description,
        "imageUrl": imageUrl
      };

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
