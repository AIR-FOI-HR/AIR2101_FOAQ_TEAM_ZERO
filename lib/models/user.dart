import 'package:flutter/foundation.dart';

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
}
