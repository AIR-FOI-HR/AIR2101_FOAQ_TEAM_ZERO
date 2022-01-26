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

  User({
    @required this.id,
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
  });

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      id: snapshot["id"],
      name: snapshot["name"],
      surname: snapshot["surname"],
      email: snapshot["email"],
      phoneNumber: snapshot["phoneNumber"],
      userImage: snapshot["userImage"],
      userRole: snapshot["userRole"],
      museumId: snapshot["museumId"]
      
    );
  }

  Map<String, dynamic> toJson() =>{
    "id": id,
    "name": name,
    "surname": surname,
    "email": email,
    "phoneNumber": phoneNumber,
    "userImage": userImage,
    "userRole": userRole,
    "museumId": museumId
  };
}
