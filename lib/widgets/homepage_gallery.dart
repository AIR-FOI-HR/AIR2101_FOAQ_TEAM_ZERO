// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/museum.dart';

class HomepageGallery extends StatelessWidget {
  final List<Museum> museum;

  HomepageGallery(this.museum);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: 520,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 4.0,
                    ),
                  )),
                  padding: EdgeInsets.fromLTRB(20, 8, 0, 0),
                  height: 40,
                  child: Text(
                    museum[index].name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    museum[index].urlPath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ));
        },
        itemCount: museum.length,
      ),
    );
  }
}
