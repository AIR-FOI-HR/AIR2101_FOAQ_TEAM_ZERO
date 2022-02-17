// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:provider/provider.dart';
import '../models/museum_halls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MuseumsHalls with ChangeNotifier {
  List<MuseumHalls> _museumsHalls = [];

  Future<void> fetchMuseumHalls() async {
    List<MuseumHalls> loadedHalls = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("museumHalls").get();
    for (var doc in querySnapshot.docs) {
      loadedHalls.add(MuseumHalls.fromSnap(doc));
    }
    _museumsHalls.clear();
    _museumsHalls = loadedHalls;
    notifyListeners();
  }

  List<MuseumHalls> getMuseumHallsById(String museumId) {
    final museumHallsData = _museumsHalls
        .where((museumHallsData) => museumHallsData.museumId == museumId)
        .toList();
    museumHallsData.sort((a, b) => a.order.compareTo(b.order));
    return museumHallsData;
  }

  List<MuseumHalls> getRecomendedRoute(
    String museumId,
    var categoryList,
  ) {
    List<MuseumHalls> recomendedRouteList = [];
    List<MuseumHalls> allMuseumHalls = getMuseumHallsById(museumId);

    for (var i = 0; i < categoryList.length; i++) {
      for (var j = 0; j < allMuseumHalls.length; j++) {
        if (categoryList[i].categoryId == allMuseumHalls[j].categoryId) {
          recomendedRouteList.add(allMuseumHalls[j]);
        }
      }
    }

    for (var i = 0; i < allMuseumHalls.length; i++) {
      bool isRecomended = true;
      for (var j = 0; j < recomendedRouteList.length; j++) {
        if (allMuseumHalls[i].categoryId == recomendedRouteList[j].categoryId) {
          isRecomended = false;
        }
      }
      if (isRecomended) {
        recomendedRouteList.add(allMuseumHalls[i]);
      }
    }

    return recomendedRouteList;
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

  void delete(String museumHallId) {
    _museumsHalls
        .removeWhere((museumHallData) => museumHallData.id == museumHallId);
    notifyListeners();
  }
}

class CategoryId {
  String categoryId;
  int count;

  CategoryId({@required this.categoryId, @required this.count});
}
