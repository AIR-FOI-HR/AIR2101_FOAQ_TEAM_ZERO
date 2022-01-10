// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/museums.dart';
import './providers/categories.dart';
import './providers/artworks.dart';

import './screens/homepage/museums_overview_screen.dart';
import './screens/museum_detail_screen.dart';
import './screens/categories/category_artwork_screen.dart';
import './screens/categories/category_artwork_editing_screen.dart';
import './screens/buy_ticket_screen.dart';
import './screens/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Museums(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Artworks(),
        )
      ],
      child: MaterialApp(
        title: 'Museum Guide',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(19, 92, 97, 1),
          accentColor: Color.fromRGBO(0, 201, 224, 1),
          primaryColorLight: Color.fromRGBO(93, 158, 163, 1),
          cardColor: Color.fromRGBO(59, 124, 129, 1),
          primaryColorDark: Color.fromRGBO(0, 39, 44, 1),
          highlightColor: Color.fromRGBO(255, 138, 68, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
                headline5: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
                headline4: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                headline3: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                button: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  backgroundColor: Color.fromRGBO(255, 138, 68, 1),
                ),
              ),
        ),
        home: MuseumsOverviewScreen(),
        routes: {
          CategoryArtworkScreen.routeName: (ctx) => CategoryArtworkScreen(),
          MuseumDetailScreen.routeName: (ctx) => MuseumDetailScreen(),
          CategoryArtworkEditingScreen.routeName: (ctx) =>
              CategoryArtworkEditingScreen(),
          BuyTicketScreen.routeName: (ctx) => BuyTicketScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
