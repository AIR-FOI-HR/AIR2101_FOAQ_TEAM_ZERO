// ignore_for_file: unused_field, prefer_final_fields

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:museum_app/firebase_managers/auth_methods.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  User _user;
  final AuthMethods _authMethods = AuthMethods();

  User getUser() {
    if (_user == null) {
      return null;
    } else {
      return _user;
    }
  }

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  List<User> get getUsers {
    return [..._users];
  }

  User findByUsername(String username) {
    return _users.firstWhere((userData) => userData.username == username,
        orElse: () => null);
  }

  bool isValidUsername(String username) {
    if (username == null || username.isEmpty || usernameTaken(username)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidEmail(String email) {
    if (email == null ||
        email.isEmpty ||
        !EmailValidator.validate(email.replaceAll(' ', ''))) {
      return true;
    } else {
      return false;
    }
  }

  bool usernameTaken(String username) {
    if (_users.firstWhere((userData) => userData.username == username,
            orElse: () => null) ==
        null) {
      return false;
    }
    return true;
  }

  bool isValidName(String name) {
    if (name == null || name.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidSurname(String surname) {
    if (surname == null || surname.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String passOne, String passTwo) {
    if (passOne == null ||
        passTwo == null ||
        passOne.isEmpty ||
        passTwo.isEmpty) {
      return true;
    } else if (passOne == passTwo) {
      return false;
    } else {
      return true;
    }
  }
}
