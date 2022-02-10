import 'package:flutter/material.dart';
import 'package:museum_app/screens/login/login_screen.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/my_profile/user_picture.dart';
import '../../providers/users.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';
import '../../widgets/my_profile/user_data_display.dart';
import '../../firebase_managers/auth_methods.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/myProfile';
  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    final mediaQuery = MediaQuery.of(context);
    final appBarProperty =
        appBar('My profile', context, Theme.of(context).primaryColor, appUser);
    final divider = Divider(
      thickness: 2,
      color: Theme.of(context).primaryColor,
    );
    return appUser == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: appBarProperty,
            drawer: MainMenuDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: (mediaQuery.size.height -
                            appBarProperty.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.4,
                    child: UserPicture(),
                  ),
                  divider,
                  Container(
                    height: (mediaQuery.size.height -
                            appBarProperty.preferredSize.height -
                            mediaQuery.padding.top -
                            30) *
                        0.55,
                    child: UserDataDisplay(),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  logOut(context);
                },
              ),
            ),
          );
  }

  void logOut(BuildContext context) async {
    await AuthMethods().signOut();
    //We remove everything from stack so user cant go back when he logs out
    Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.routeName, (Route<dynamic> route) => false);
  }
}
