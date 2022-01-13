import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/my_profile/user_picture.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/myProfile';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('My profile', context, Theme.of(context).primaryColor);
    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Column(
        children: [
          Container(
              height: (mediaQuery.size.height -
                      appBarProperty.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.4,
              child: UserPicture()),
        ],
      ),
    );
  }
}
