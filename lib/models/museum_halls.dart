import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:museum_app/models/museum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MuseumHalls with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final int order;
  final String museumId;
  final String categoryId;

  MuseumHalls({
    this.id,
    @required this.name,
    this.description,
    @required this.order,
    @required this.museumId,
    @required this.categoryId,
  });

  static MuseumHalls fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MuseumHalls(
        id: snap.id,
        categoryId: snapshot["category"],
        museumId: snapshot["museum"],
        name: snapshot["name"],
        order: snapshot["order"],
        description: snapshot["description"]);
  }

  Map<String, dynamic> toJson() => {
        "category": categoryId,
        "museum": museumId,
        "name": name,
        "order": order,
        "description": description
      };
}
