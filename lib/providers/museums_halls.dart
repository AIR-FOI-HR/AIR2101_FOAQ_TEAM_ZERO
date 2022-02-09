// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:provider/provider.dart';
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
      id: '2',
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

  MuseumHalls getOneMuseumHallById(String museumHallId) {
    return _museumsHalls
        .firstWhere((museumHallData) => museumHallData.id == museumHallId);
  }

  void addNewMuseumHall(MuseumHalls museumHallData) {
    final newMuseumHall = MuseumHalls(
      id: (_museumsHalls.length + 1).toString(),
      name: museumHallData.name,
      order: museumHallData.order,
      museumId: museumHallData.museumId,
      categoryId: museumHallData.categoryId,
      description: museumHallData.description,
    );
    _museumsHalls.add(newMuseumHall);
    notifyListeners();
  }

  void updateMuseumHall(MuseumHalls museumHallData, BuildContext context) {
    final museumHallIndex = _museumsHalls
        .indexWhere((museumHallData) => museumHallData.id == museumHallData.id);
    if (museumHallIndex >= 0) {
      _museumsHalls[museumHallIndex] = museumHallData;
      notifyListeners();
    }
  }
}
