import 'package:flutter/material.dart';

import '../widgets/homepage_gallery.dart';
import '../models/museum.dart';

class AdminMuseum extends StatefulWidget {
  @override
  _AdminAddMuseumState createState() => _AdminAddMuseumState();
}

class _AdminAddMuseumState extends State<AdminMuseum> {
  final List<Museum> _museumList = [
    Museum(
        id: '1',
        name: 'Gladiator museum',
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

  void _addNewMuseum(
    String museumName,
    String museumAddress,
    double museumTourDuration,
    String museumUrlPath,
    String museumId,
  ) {
    final newMuseum = Museum(
      name: museumName,
      address: museumAddress,
      tourDuration: museumTourDuration,
      urlPath: museumUrlPath,
      id: (_museumList.length + 1).toString(),
    );

    setState(() {
      _museumList.add(newMuseum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomepageGallery(_museumList),
      ],
    );
    ;
  }
}
