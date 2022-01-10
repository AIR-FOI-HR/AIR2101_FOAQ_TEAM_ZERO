import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/userLogin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Login', context, Theme.of(context).primaryColor),
      drawer: MainMenuDrawer(),
    );
  }
}
