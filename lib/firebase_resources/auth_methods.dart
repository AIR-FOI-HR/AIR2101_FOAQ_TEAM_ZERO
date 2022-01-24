import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerUser(
      {@required String username,
      @required String email,
      @required String name,
      @required String surname,
      @required String password}) async {
        String res = "Error while registering user";
        try{
          UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          
        }catch(error){
          return error.toString();
        }
      }
}
