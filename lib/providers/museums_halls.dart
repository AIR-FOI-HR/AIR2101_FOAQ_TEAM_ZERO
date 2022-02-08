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
      categoryId: 'c10',
    ),
    MuseumHalls(
      id: '1',
      name: 'Painting artwork',
      order: 2,
      museumId: '2',
      categoryId: 'c11',
    ),
  ];

  List<MuseumHalls> getMuseumHallsById(String museumId) {
    return _museumsHalls
        .where((museumHallsData) => museumHallsData.museumId == museumId);
  }
}
