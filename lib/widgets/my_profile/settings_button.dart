// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../screens/my_profile/my_profile_editing_screen.dart';

class SettingsButton extends StatelessWidget {
  BoxConstraints constraints;
  SettingsButton(this.constraints, {Key key}) : super(key: key);
  final username = 'msakac';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 80, right: 80),
      width: double.infinity,
      height: constraints.maxHeight * 0.15,
      child: Center(
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyProfileEditingScreen.routeName,
                  arguments: username);
            },
            style: ElevatedButton.styleFrom(
              primary: color.highlightColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
            child: Text('Settings', style: color.textTheme.headline5),
          ),
        ),
      ),
    );
  }
}
