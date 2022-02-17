import 'package:flutter/material.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/screens/museum_owner/museum_owner_screen.dart';
import '../../providers/artworks.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';
import '../../models/museum.dart';
import '../../models/user.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museum_owners/museum_owners.dart';

import '../../widgets/artworks/manage_artwork_item.dart';
import '../../widgets/error_dialog.dart';

class addMuseumOwnerscreen extends StatefulWidget {
  static const routeName = '/add-museum-owner';

  @override
  State<addMuseumOwnerscreen> createState() => _addMuseumOwnerscreen();
}

class _addMuseumOwnerscreen extends State<addMuseumOwnerscreen> {
  @override
  Widget build(BuildContext context) {
    String museum = '';
    Museum muzej;
    String email = '';
    User appUser = Provider.of<Users>(context).getUser();
    ThemeData color = Theme.of(context);
    final _formKey = GlobalKey<FormState>();
    final appBarProperty = appBar(
        'Add museum owner', context, Theme.of(context).primaryColor, appUser);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    Map<String, String> museumsMap = {};
    Provider.of<Museums>(context)
        .getMuseums
        .forEach((museum) => museumsMap[museum.id] = museum.name);

    const ServiceId = 'service_o1t4if7';
    const TemplateId = 'template_1mil3cm';
    const UserId = 'user_iHuBj6o76EOyDhTKR1ZAE';

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field cannot be empty!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                DropDownField(
                  textStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                  labelStyle:
                      TextStyle(fontSize: 16, color: color.primaryColor),
                  icon: Icon(Icons.museum, color: color.primaryColor),
                  enabled: true,
                  required: true,
                  labelText: 'Museum',
                  items: museumsMap.values.toList(),
                  onValueChanged: (value) {
                    museum = museumsMap.keys
                        .firstWhere((key) => museumsMap[key] == value);
                    muzej = Provider.of<Museums>(context, listen: false)
                        .getById(museum);
                  },
                ),
              ],
            ),
          )),
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              backgroundColor: color.highlightColor,
              child: IconButton(
                onPressed: () {
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
                        'usermail': email,
                        'username': username,
                        'password': password,
                        'museum': muzej.name,
                      },
                    }),
                  );
                  Provider.of<Users>(context, listen: false).addNewOwner(
                      username, email, username, username, password, museum);
                  Navigator.of(context)
                      .pushNamed(ManageMuseumOwnersScreen.routeName);
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
