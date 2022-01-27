import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryArtwork {
  final String id;
  final String name;

  CategoryArtwork({
    this.id,
    @required this.name,
  });

  static CategoryArtwork fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, String>;
    return CategoryArtwork(
      id: snap.id,
      name: snap["name"],
    );
  }

  Map<String, dynamic> toJson() => {"name": name};
}
