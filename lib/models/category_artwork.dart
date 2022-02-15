import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryArtwork with ChangeNotifier {
  final String id;
  final String name;

  CategoryArtwork({
    this.id,
    @required this.name,
  });

  static CategoryArtwork fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CategoryArtwork(
      id: snap.id,
      name: snapshot["name"],
    );
  }

  Map<String, dynamic> toJson() => {"name": name};
}
