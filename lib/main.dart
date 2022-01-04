// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';

import './widgets/homepage_gallery.dart';
import './widgets/app_bar_property.dart';
import './widgets/main_manu_drawer.dart';
import './widgets/category_name_homepage.dart';
import './widgets/search_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(19, 92, 97, 1),
        accentColor: Color.fromRGBO(236, 219, 172, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
              headline5: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromRGBO(236, 219, 172, 1),
              ),
              button: TextStyle(
                color: Theme.of(context).accentColor,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = appBarProperty(title: 'Museum App', context: context);
    final searchBarProperty = SearchBar();
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.07,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Newest Artwork',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SearchBar(),
                  ],
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.93,
              padding: EdgeInsets.only(bottom: 6),
              child: HomepageGallery(),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
