// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './my_profile_atributs.dart';
import '../../providers/users.dart';

class UserDataColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context).getUser();
    print(userData.userImage);
    final divider = Divider(
      thickness: 2,
      color: Theme.of(context).primaryColorDark,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyProfileAtributs('Name:', userData.name),
        divider,
        MyProfileAtributs('Surname:', userData.surname),
        divider,
        MyProfileAtributs('Email:', userData.email),
        divider,
        MyProfileAtributs('Phone:',
            userData.phoneNumber.isEmpty ? 'not added' : userData.phoneNumber),
      ],
    );
  }
}
