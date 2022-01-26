import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser({
    @required String username,
    @required String email,
    @required String name,
    @required String surname,
    @required String password,
  }) async {
    String result = "Error while registering user";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      model.User _user = model.User(
        email: email,
        id: cred.user.uid,
        name: name,
        surname: surname,
        userRole: '1',
        username: username,
        phoneNumber: null,
        userImage: null,
        museumId: null,
      );
      await _firestore
          .collection("users")
          .doc(cred.user.uid)
          .set(_user.toJson());

      result = "Success";
    } catch (error) {
      switch (error.code) {
        case "email-already-in-use":
          result = "The email address is already in use by another account.";
          break;
        case "weak-password":
          result = "Password should be at least 6 characters";
          break;
        default:
          result= "Ugh Ough, something went wront!";
      }
    }
    return result;
  }
}
