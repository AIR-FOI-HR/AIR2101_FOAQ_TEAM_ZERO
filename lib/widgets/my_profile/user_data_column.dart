// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './my_profile_atributs.dart';
import '../../providers/users.dart';
import '../../providers/museums.dart';

class UserDataColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context).getUser();

    String getType() {
      int role = int.parse(userData.userRole);
      if (userData.museumId != "") {
        final museum = Provider.of<Museums>(context).getById(userData.museumId);
        if (role == 2) {
          return "Moderator in:\n ${museum.name}";
        } else if (role == 3) {
          return "Museum Owner of:\n ${museum.name}";
        }
      } else {
        if (role == 1) {
          return "Registered user";
        } else {
          return "System Admin";
        }
      }
    }

    final divider = Divider(
      thickness: 2,
      color: Theme.of(context).primaryColorDark,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyProfileAtributs('Name:', userData.name + " " + userData.surname),
        divider,
        MyProfileAtributs('Type:', getType()),
        divider,
        MyProfileAtributs('Email:', userData.email),
        divider,
        MyProfileAtributs('Phone:',
            userData.phoneNumber.isEmpty ? 'not added' : userData.phoneNumber),
      ],
    );
  }
}
