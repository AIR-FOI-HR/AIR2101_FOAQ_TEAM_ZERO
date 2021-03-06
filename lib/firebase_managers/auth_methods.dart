import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import '../models/user.dart' as model;
import 'db_caller.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser({
    @required String username,
    @required String email,
    @required String name,
    @required String surname,
    @required String password,
    String museum,
    bool isOwner,
  }) async {
    String result = "Ugh Ough, something went wront!";
    model.User _user;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.replaceAll(' ', ''),
        password: password,
      );
      //Adding Museum owner
      if (museum != null && isOwner) {
        _user = model.User(
            email: email,
            id: cred.user.uid,
            name: name,
            surname: surname,
            userRole: '3',
            username: username,
            phoneNumber: "",
            userImage: "",
            museumId: museum,
            favoriteArtworks: []);
        //Adding Moderator
      } else if (museum != null && !isOwner) {
        _user = model.User(
            email: email,
            id: cred.user.uid,
            name: name,
            surname: surname,
            userRole: '2',
            username: username,
            phoneNumber: "",
            userImage: "",
            museumId: museum,
            favoriteArtworks: []);
        //Adding Normal user
      } else {
        _user = model.User(
            email: email,
            id: cred.user.uid,
            name: name,
            surname: surname,
            userRole: '1',
            username: username,
            phoneNumber: "",
            userImage: "",
            museumId: "",
            favoriteArtworks: []);
      }

      await DBCaller.createUser(_user, cred.user.uid);

      result = "Success";
    } catch (error) {
      switch (error.code) {
        case "email-already-in-use":
          result = "The email address is already in use by another account.";
          break;
        case "weak-password":
          result = "Password should be at least 6 characters";
          break;
      }
    }
    return result;
  }

  Future<String> loginUser({
    @required String email,
    @required String password,
  }) async {
    String result = "Ugh Ough, something went wront!";
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.replaceAll(' ', ''), password: password);

      result = "Success";
    } catch (error) {
      print(error
          .code); //invalid-email, null kad nemam nicega, wrong password, user-not-found
      switch (error.code) {
        case "invalid-email":
          result = "Oops! E-mail is not valid or is not registered";
          break;
        case "wrong-password":
          result = "Oops! Wrong password";
          break;
        case "user-not-found":
          result = "Oops! E-mail is not valid or is not registered";
          break;
        default:
          result = "Oops! You need to enter Email and Password";
      }
    }
    return result;
  }

  Future<bool> isLoggedIn() async {
    User currentUser = _auth.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser;
    if (currentUser == null) {
      return null;
    } else {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();
      return model.User.fromSnap(documentSnapshot);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    getUserDetails();
  }
}
