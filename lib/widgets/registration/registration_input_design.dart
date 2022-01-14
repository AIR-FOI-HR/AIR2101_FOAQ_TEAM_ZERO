import 'package:flutter/material.dart';
import 'package:museum_app/widgets/login/user_login_title.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

import '../login/box_decoration_property.dart';
import '../login/check_box.dart';
import '../../screens/login/login_screen.dart';

class RegistrationInputDesign extends StatefulWidget {
  @override
  State<RegistrationInputDesign> createState() =>
      _RegistrationInputDesignState();
}

class _RegistrationInputDesignState extends State<RegistrationInputDesign> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();
  TextEditingController surnameControler = TextEditingController();
  TextEditingController passwordOneControler = TextEditingController();
  TextEditingController passwordTwoControler = TextEditingController();

  bool isChecked = false;
  bool usernameBool = false;
  bool emailBool = false;
  bool nameBool = false;
  bool surnameBool = false;
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
          return Form(
            key: _formKey,
            child: Column(
              children: [
                UserLoginTitle('Registration', constraints),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                      ),
                      textField(
                        constraints,
                        usernameBool,
                        TextField(
                          controller: usernameControler,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      textField(
                        constraints,
                        emailBool,
                        TextField(
                          controller: emailControler,
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      textField(
                        constraints,
                        nameBool,
                        TextField(
                          controller: nameControler,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      textField(
                        constraints,
                        surnameBool,
                        TextField(
                          controller: surnameControler,
                          decoration: const InputDecoration(
                            hintText: 'Surname',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      textField(
                        constraints,
                        passwordBool,
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordOneControler,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      textField(
                        constraints,
                        passwordBool,
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordTwoControler,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
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
                            child: Text('I agree'),
                          ),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        color.buttonColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  usernameBool = userProvider
                                      .isValidUsername(usernameControler.text);
                                  emailBool = userProvider
                                      .isValidEmail(emailControler.text);
                                  nameBool = userProvider
                                      .isValidName(nameControler.text);
                                  surnameBool = userProvider
                                      .isValidSurname(surnameControler.text);
                                  passwordBool = userProvider.isValidPassword(
                                      passwordOneControler.text,
                                      passwordTwoControler.text);
                                });
                                if (!usernameBool &&
                                    !emailBool &&
                                    !nameBool &&
                                    !surnameBool &&
                                    !passwordBool) {
                                  userProvider.addNewUser(
                                    usernameControler.text,
                                    emailControler.text,
                                    nameControler.text,
                                    surnameControler.text,
                                    passwordOneControler.text,
                                  );

                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.routeName);
                                }
                              },
                              child: FittedBox(
                                child: Text(
                                  'Register',
                                  style: color.textTheme.headline1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget textField(
      BoxConstraints constraints, bool color, TextField textField) {
    return Container(
      height: constraints.maxHeight * 0.08,
      padding: EdgeInsets.only(left: 20),
      decoration:
          boxDecoration(context, color ? Colors.red[100] : Colors.white),
      child: textField,
    );
  }
}
