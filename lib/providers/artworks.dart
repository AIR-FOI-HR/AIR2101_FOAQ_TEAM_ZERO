// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/artwork.dart';
import '../models/museum.dart';
import '../providers/museums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Artworks with ChangeNotifier {
  List<Artwork> _artworks = [];
  final urlArtworks = Uri.parse(
      'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks.json');

  List getCategoryFromMuseum(String museumId) {
    var _categoryList = [];
    List<Artwork> _museumAllArtworks = _artworks
        .where((artworkData) => artworkData.museum == museumId)
        .toList();

    for (int i = 0; i < _museumAllArtworks.length; i++) {
      _categoryList.add(_museumAllArtworks[i].category);
    }
    return _categoryList.toSet().toList();
  }

  List<Artwork> get getArtworks {
    return [..._artworks];
  }

  Future<void> fetchArtworks() async {
    List<Artwork> loadedArtworks = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("artworks").get();

    for (var doc in querySnapshot.docs) {
      loadedArtworks.add(Artwork.fromSnap(doc));
    }
    _artworks.clear();
    _artworks = loadedArtworks;
    print("Artworki: " + _artworks.length.toString());
    notifyListeners();
  }

  List<Artwork> getByMuseumId(String id) {
    return _artworks.where((artwork) => artwork.museum == id).toList();
  }

  List<Artwork> getByCategory(String categoryId) {
    print("Artworki getByCategory: " + _artworks.length.toString());
    return _artworks
        .where((artwork) => artwork.category == categoryId)
        .toList();
  }

  Artwork getById(String id) {
    return _artworks.firstWhere((artwork) => artwork.id == id);
  }

  void deleteArtwork(String id) {
    _artworks.removeWhere((artwork) => artwork.id == id);
    notifyListeners();
  }
}
