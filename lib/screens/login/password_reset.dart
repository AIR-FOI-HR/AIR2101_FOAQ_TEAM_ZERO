import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/widgets/app_bar.dart';
import 'package:museum_app/widgets/login/box_decoration_property.dart';
import 'package:museum_app/widgets/login/display_logo.dart';
import 'package:museum_app/widgets/login/user_login_title.dart';
import 'package:museum_app/widgets/main_menu_drawer.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart' as model;

class PasswordReset extends StatefulWidget {
  static const routeName = '/passwordReset';

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String message = "";

  void resetPassword() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoading = true;
    });
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
      setState(() {
        _isLoading = false;
        message =
            "Reset link has been sent to the your e-mail.\nIf you don't receive an email then try agan to Send reset link.";
        emailController.text = "";
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        message =
            "Woops, looks like something went wrong..\n Your given e-mail was not found..";
        emailController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User appUser = Provider.of<Users>(context).getUser();
    final color = Theme.of(context);
    final appBarProperty = appBar(
        'Password reset', context, Theme.of(context).primaryColor, appUser);
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
                    0.7,
                child: Container(
                  width: double.infinity,
                  decoration: boxDecoration(context, color.shadowColor),
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Column(
                        children: [
                          UserLoginTitle('Reset your password', constraints),
                          SizedBox(
                            height: constraints.maxHeight * 0.15,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.08,
                                  padding: const EdgeInsets.only(left: 20),
                                  decoration:
                                      boxDecoration(context, Colors.white),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      hintText: 'E-mail',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  color.buttonColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () => resetPassword(),
                                        child: FittedBox(
                                          child: _isLoading
                                              ? SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 3,
                                                          color: color
                                                              .primaryColor),
                                                )
                                              : Text(
                                                  'Send reset link',
                                                  style:
                                                      color.textTheme.headline1,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: constraints.maxHeight * 0.07),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
