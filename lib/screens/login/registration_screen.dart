import 'package:flutter/material.dart';
import '../../widgets/login/display_logo.dart';
import '../../widgets/registration/registration_input_design.dart';
import '../../widgets/app_bar.dart';
import '../../providers/users.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/userRegistration';
  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    final color = Theme.of(context);
    final appBarProperty = appBar('Registration', context, color.primaryColor,appUser);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarProperty,
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
                    0.72,
                child: RegistrationInputDesign(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
