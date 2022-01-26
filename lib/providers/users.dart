// ignore_for_file: unused_field, prefer_final_fields

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:museum_app/firebase_resources/auth_methods.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  List<User> _users = [
    User(
      id: 'u1',
      name: 'Tomislav',
      surname: 'Tomiek',
      username: 'ttomiek',
      email: 'ttomiek@foi.hr',
      password:
          'bb880fc496fb66c43cedd293c37a09d1905db468eb57c3f2d698778150065f83',
      salt: 'd367a4d778f157a872bc8e2ebcd332b784137777fef6a8438b9d0f9c9ed6532a',
      userRole: '1',
      phoneNumber: '0951234567',
      museumId: '2',
    ),
    User(
      id: 'u2',
      name: 'Martin',
      surname: 'Sakač',
      username: 'msakac',
      email: 'msakac@foi.hr',
      password:
          'cb8e21e75482d6cc5d70478d36fdce4f5dd9cb530d638304b39a778e785250f9',
      salt: '3d9601254b9e4c5c887d1dee098acbb9cbf3975d47f8246aeb095c520c620463',
      userRole: '1',
      userImage: 'https://i.imgur.com/BoN9kdC.png',
      phoneNumber: '',
    )
  ];
  
  
  User _user;

  final AuthMethods _authMethods = AuthMethods();

  User getUser(){
    if(_user == null){
      return null;
    }else{
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

  bool checkUserData(String inputUsername, String inputPassword) {
    var currentUser = findByUsername(inputUsername);
    if (currentUser != null) {
      var inputSalt = useHash(inputPassword + currentUser.salt);
      if (currentUser.password == inputSalt) return true;
    }
    return false;
  }

  String useHash(String secret) {
    var salt = utf8.encode(secret);
    return sha256.convert(salt).toString();
  }

  bool isValidUsername(String username) {
    if (username == null || username.isEmpty || usernameTaken(username)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidEmail(String email) {
    if (email == null || email.isEmpty || !EmailValidator.validate(email)) {
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

  void addNewUser(
    String username,
    String email,
    String name,
    String surname,
    String pass,
  ) {
    var newId = (_users.length + 1).toString();
    var salt = useHash(username);
    var password = useHash(pass + salt);
    _users.insert(
      0,
      User(
        id: newId,
        name: name,
        surname: surname,
        username: username,
        email: email,
        password: password,
        salt: salt,
        userRole: '0',
      ),
    );
  }

  void updateUser(String id, User userData) {
    final userIndex =
        _users.indexWhere((userDataElement) => userDataElement.id == id);
    if (userIndex >= 0) {
      _users[userIndex] = userData;
      notifyListeners();
    }
  }
}
