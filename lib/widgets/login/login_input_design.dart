import 'package:flutter/material.dart';

import './user_button.dart';
import './box_decoration_property.dart';
import './design_text_field.dart';

class LoginInputDesign extends StatefulWidget {
  @override
  State<LoginInputDesign> createState() => _LoginInputDesignState();
}

class _LoginInputDesignState extends State<LoginInputDesign> {
  TextEditingController usernameControler = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);

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
                    DesignTextField(
                        TextField(
                          controller: usernameControler,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                          ),
                        ),
                        constraints),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    DesignTextField(
                        TextField(
                          controller: usernameControler,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                        constraints),
                    SizedBox(
                      height: constraints.maxHeight * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                fillColor: MaterialStateProperty.all(
                                    color.primaryColor),
                                value: isChecked,
                                onChanged: (_) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                }),
                          ),
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
                            onPressed: () {},
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
