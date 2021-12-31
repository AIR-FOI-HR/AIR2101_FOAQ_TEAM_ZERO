// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/museum.dart';

class HomepageGallery extends StatelessWidget {
  final List<Museum> _museumList = [
    Museum(
        id: '1',
        name: 'Gladiator MuseumList',
        address: 'Piazza Navona, 90, 00186 Roma RM, Italija',
        tourDuration: 45,
        urlPath: 'assets/images/Gladiator.png'),
    Museum(
        id: '2',
        name: 'Doria Pamhili Gallery',
        address: 'Via del Corso, 305, 00186 Roma RM, Italija',
        tourDuration: 50,
        urlPath: 'assets/images/Doria_Pamphili.png'),
    Museum(
        id: '3',
        name: 'Capitoline Museum',
        address: 'Piazza del Campidoglio, 1, 00186 Roma RM, Italija',
        tourDuration: 30,
        urlPath: 'assets/images/Capitolini.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _museumList.length,
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
                    _museumList[index].name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    _museumList[index].urlPath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
