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

  static Museum fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Museum(
      id: snap.id,
      name: snapshot["name"],
      address: snapshot["address"],
      description: snapshot["description"],
      imageUrl: snapshot["imageUrl"],
      location: snapshot["location"],
      capacity: snapshot["capacity"],
      tourDuration: snapshot["tourDuration"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "description": description,
        "imageUrl": imageUrl,
        "location": location,
        "capacity": capacity,
        "tourDuration": tourDuration
      };
}
