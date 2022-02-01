import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Museum with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String address;
  final double tourDuration;
  final String imageUrl;
  final String location;
  final int capacity;

  //only id and name are required. If sys admin creates new museum he only has to give museum the name.
  //museum admin can then add other info about the museum
  Museum({
    this.id,
    @required this.name,
    this.description,
    this.address,
    this.tourDuration,
    this.imageUrl,
    this.location,
    this.capacity,
  });

  static Museum fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, String>;
    return Museum(
      id: snap.id,
      name: snap["name"],
      address: snap["address"],
      description: snap["description"],
      imageUrl: snap["imageUrl"],
      location: snap["location"],
      tourDuration: snap["tourDuration"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "description": description,
        "imageUrl": imageUrl,
        "location": location,
        "tourDuration": tourDuration
      };
}
