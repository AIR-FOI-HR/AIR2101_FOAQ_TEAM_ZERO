import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';
import './user_button.dart';
import './box_decoration_property.dart';
import './check_box.dart';

class LoginInputDesign extends StatefulWidget {
  @override
  State<LoginInputDesign> createState() => _LoginInputDesignState();
}

class _LoginInputDesignState extends State<LoginInputDesign> {
  TextEditingController usernameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  bool isChecked = false;
  bool usernameBool = false;
  bool passwordBool = false;

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
              Container(
                width: double.infinity,
                height: constraints.maxHeight * 0.15,
                decoration: boxDecoration(context, color.primaryColor),
                child: Center(
                  child: Text(
                    'Login',
                    style: color.textTheme.headline2,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.03,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.08,
                      padding: EdgeInsets.only(left: 20),
                      decoration: boxDecoration(context, Colors.white),
                      child: TextField(
                        controller: usernameControler,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.08,
                      padding: EdgeInsets.only(left: 20),
                      decoration: boxDecoration(context, Colors.white),
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
                            onPressed: () {
                              bool checkedUser = userProvider.checkUserData(
                                  usernameControler.text,
                                  passwordControler.text);
                              if (userProvider
                                      .findByUsername(usernameControler.text) ==
                                  null)
                                setState(() {
                                  usernameBool = !usernameBool;
                                });
                              checkedUser
                                  ? Navigator.of(context)
                                      .pushReplacementNamed('/')
                                  : null;
                            },
                            child: FittedBox(
                              child: Text(
                                'Login',
                                style: color.textTheme.headline1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.12),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          UserButton('I forgot my password', () {}),
                          SizedBox(height: constraints.maxHeight * 0.01),
                          UserButton('I don\'t have account', () {}),
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
