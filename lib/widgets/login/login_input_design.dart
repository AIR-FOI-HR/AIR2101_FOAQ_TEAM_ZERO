import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/auth_methods.dart';
import 'package:museum_app/screens/login/password_reset.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';
import '../../screens/login/registration_screen.dart';

import './user_button.dart';
import './box_decoration_property.dart';
import './check_box.dart';
import './user_login_title.dart';
import '../utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginInputDesign extends StatefulWidget {
  @override
  State<LoginInputDesign> createState() => _LoginInputDesignState();
}

class _LoginInputDesignState extends State<LoginInputDesign> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  bool isChecked = false;
  bool usernameBool = false;
  bool passwordBool = false;
  bool _isLoading = false;

  void refreshUser() async {
    Users _userProvider = Provider.of<Users>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    refreshUser();
    super.initState();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
        email: emailController.text, password: passwordControler.text);
    if (result == "Success") {
      Users _userProvider = Provider.of<Users>(context, listen: false);
      await _userProvider.refreshUser();
      Navigator.of(context).pushReplacementNamed('/');
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final userProvider = Provider.of<Users>(context);

    return Container(
      width: double.infinity,
      decoration: boxDecoration(context, color.shadowColor),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              UserLoginTitle('Login', constraints),
              SizedBox(
                height: constraints.maxHeight * 0.05,
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
                      decoration: boxDecoration(context,
                          usernameBool ? Colors.red[100] : Colors.white),
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
                    Container(
                      height: constraints.maxHeight * 0.08,
                      padding: const EdgeInsets.only(left: 20),
                      decoration: boxDecoration(context,
                          passwordBool ? Colors.red[100] : Colors.white),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordControler,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CheckBox(),
                        ),
                        const Expanded(
                          flex: 3,
                          child: Text('Stay logged in'),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  color.buttonColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            onPressed: () => loginUser(),
                            child: FittedBox(
                              child: _isLoading
                                  ? SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: color.primaryColor),
                                    )
                                  : Text(
                                      'Login',
                                      style: color.textTheme.headline1,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.046),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          UserButton('I forgot my password', () {
                            Navigator.of(context)
                                .pushNamed(PasswordReset.routeName);
                          }),
                          SizedBox(height: constraints.maxHeight * 0.01),
                          UserButton('I don\'t have account', () {
                            Navigator.of(context)
                                .pushNamed(RegistrationScreen.routeName);
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
