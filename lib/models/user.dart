import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final String salt;
  final String userImage;
  final String userRole;
  final String museumId;
  final List<dynamic> favoriteArtworks;

  User(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.username,
      @required this.email,
      this.phoneNumber,
      @required this.password,
      @required this.salt,
      this.userImage,
      @required this.userRole,
      this.museumId,
      this.favoriteArtworks});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot["favoriteArtworks"]);
    return User(
        id: snap.id,
        username: snapshot["username"],
        name: snapshot["name"],
        surname: snapshot["surname"],
        email: snapshot["email"],
        phoneNumber: snapshot["phoneNumber"],
        userImage: snapshot["userImage"],
        userRole: snapshot["userRole"],
        museumId: snapshot["museumId"],
        favoriteArtworks: snapshot["favoriteArtworks"] ?? []);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
        "email": email,
        "phoneNumber": phoneNumber,
        "userImage": userImage,
        "userRole": userRole,
        "museumId": museumId,
        "favoriteArtworks": favoriteArtworks.isEmpty ? [] : favoriteArtworks
      };
}
