import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/myProfile';
  @override
  Widget build(BuildContext context) {
    final appBarProperty =
        appBar('My profile', context, Theme.of(context).primaryColor);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Column(
        children: [],
      ),
    );
  }
}
