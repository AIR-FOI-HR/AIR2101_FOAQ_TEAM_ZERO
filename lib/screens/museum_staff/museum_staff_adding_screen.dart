import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/auth_methods.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/screens/museum_staff/museum_staff_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../providers/users.dart';
import 'dart:convert';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museumStaff/museumStaff.dart';
import 'dart:math';
import '../../providers/users.dart';

class addStaff extends StatefulWidget {
  static const routeName = '/add-edit-staff';

  @override
  State<addStaff> createState() => _addStaffScreenState();
}

class _addStaffScreenState extends State<addStaff> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    Museum muzej =
        Provider.of<Museums>(context, listen: false).getById(appUser.museumId);

    ThemeData color = Theme.of(context);
    final appBarProperty = appBar(
        'Add museum staff', context, Theme.of(context).primaryColor, appUser);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    const ServiceId = 'service_o1t4if7';
    const TemplateId = 'template_wmrxjj5';
    const UserId = 'user_iHuBj6o76EOyDhTKR1ZAE';
    String email = '';

    return Scaffold(
      appBar: appBarProperty,
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 12),
                TextFormField(
                  decoration: inputDecoration('Email', Icons.email, color),
                  onChanged: (value) {
                    email = value;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field cannot be empty!';
                    }
                    return null;
                  },
                )
              ],
            ),
          )),
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              backgroundColor: color.highlightColor,
              child: IconButton(
                onPressed: () async {
                  _formKey.currentState.save();
                  var username = getRandomString(6);
                  var password = getRandomString(6);
                  final url =
                      Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
                  final response = http.post(
                    url,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: json.encode({
                      'service_id': ServiceId,
                      'template_id': TemplateId,
                      'user_id': UserId,
                      'template_params': {
                        'username': username,
                        'password': password,
                        'usermail': email.replaceAll(' ', ''),
                        'museum': muzej.name,
                      },
                    }),
                  );
                  print("adadada" + email);
                  Provider.of<Users>(context, listen: false).addNewStaff(
                      username,
                      email,
                      username,
                      username,
                      password,
                      appUser.museumId);

                  await AuthMethods()
                      .registerUser(
                          username: username,
                          email: email,
                          name: username,
                          surname: username,
                          password: password,
                          museum: muzej.id,
                          isOwner: false)
                      .then((value) {
                    print(value);
                    Navigator.of(context)
                        .pushNamed(ManageMuseumStaff.routeName);
                  });
                },
                icon: Icon(
                  Icons.check,
                  color: color.primaryColor,
                  size: 35,
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  InputDecoration inputDecoration(
      String hintText, IconData icon, ThemeData color) {
    return InputDecoration(
      labelText: hintText,
      labelStyle: TextStyle(fontSize: 16, color: color.primaryColor),
      border: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(25.0)),
      prefixIcon: Icon(
        icon,
        color: color.primaryColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.highlightColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }
}
