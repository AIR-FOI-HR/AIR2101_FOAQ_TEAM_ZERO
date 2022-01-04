// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:provider/provider.dart';

import './screens/museums_overview_screen.dart';
import './providers/museums.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Museums(),
        ),
      ],
      child: MaterialApp(
        title: 'Museum Guide',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(19, 92, 97, 1),
          accentColor: Color.fromRGBO(236, 219, 172, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                ),
                headline5: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
                button: TextStyle(
                  color: Theme.of(context).accentColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
        ),
        home: MuseumsOverviewScreen(),
      ),
    );
  }
}













