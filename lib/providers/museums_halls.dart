// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import '../models/museum_halls.dart';

class MuseumsHalls with ChangeNotifier {
  List<MuseumHalls> _museumsHalls = [
    MuseumHalls(
      id: '1',
      name: 'Print artwork',
      order: 1,
      museumId: '2',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut' +
          'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris' +
          'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit ' +
          'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in ' +
          'culpa qui officia deserunt mollit anim id est laborum.',
      categoryId: 'c10',
    ),
    MuseumHalls(
      id: '1',
      name: 'Painting artwork',
      order: 2,
      museumId: '2',
      categoryId: 'c11',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut' +
              'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris' +
              'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit ',
    ),
  ];

  List<MuseumHalls> getMuseumHallsById(String museumId) {
    final museumHallsData = _museumsHalls
        .where((museumHallsData) => museumHallsData.museumId == museumId)
        .toList();
    museumHallsData.sort((a, b) => a.order.compareTo(b.order));
    return museumHallsData;
  }
}
