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

  Artwork({
    this.id,
    @required this.name,
    this.imageUrl,
    this.description,
    this.author,
    @required this.museum,
    @required this.category,
  });

  static Artwork fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Artwork(
      id: snap.id,
      category: snapshot["category"],
      museum: snapshot["museum"],
      name: snapshot["name"],
      author: snapshot["author"],
      description: snapshot["description"],
      imageUrl: snapshot["imageUrl"],
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
}
