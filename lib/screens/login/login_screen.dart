import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/login/display_logo.dart';
import '../../widgets/login/login_input_design.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/userLogin';

  @override
  Widget build(BuildContext context) {
    final appBarProperty =
        appBar('Login', context, Theme.of(context).primaryColor);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: appBarProperty,
        drawer: MainMenuDrawer(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 50),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: (mediaQuery.size.height -
                            appBarProperty.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.2,
                    child: DisplayLogo()),
                Container(
                  height: (mediaQuery.size.height -
                          appBarProperty.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: LoginInputDesign(),
                ),
              ],
            ),
          ),
        ));
  }
}
