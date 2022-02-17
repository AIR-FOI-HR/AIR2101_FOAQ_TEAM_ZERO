// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/artwork.dart';
import '../models/museum.dart';
import '../models/user.dart';
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

  List<Artwork> getUserFavoriteArtworks(List<dynamic> favoriteArtworks) {
    List<Artwork> artworks = [];
    for (var i = favoriteArtworks.length - 1; i >= 0; i--) {
      artworks.add(
          _artworks.firstWhere((element) => element.id == favoriteArtworks[i]));
    }
    return artworks;
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

  List<Artwork> getArtworksByMuseumIdAndCategory(
      {String museumId, String categoryId}) {
    return _artworks
        .where((artworkData) =>
            artworkData.museum == museumId &&
            artworkData.category == categoryId)
        .toList();
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

  List<CategoryId> getCategoryId(User userData) {
    List userFavoriteArtwork = userData.favoriteArtworks;
    List<CategoryId> userFavoriteCategory = [];
    for (var i = 0; i < userFavoriteArtwork.length; i++) {
      bool categoryFind = true;
      if (userFavoriteCategory != null) {
        var artwork = _artworks.firstWhere(
            (artworkData) => artworkData.id == userFavoriteArtwork[i]);
        for (var j = 0; j < userFavoriteCategory.length; j++) {
          if (userFavoriteCategory[j].categoryId == artwork.category) {
            userFavoriteCategory[j].count++;
            categoryFind = false;
          }
        }
        if (categoryFind) {
          var newCategoryId =
              CategoryId(categoryId: artwork.category, count: 1);
          userFavoriteCategory.add(newCategoryId);
        }
      }
    }

    userFavoriteCategory.sort((a, b) => b.count.compareTo(a.count));

    return userFavoriteCategory;
  }
}

class CategoryId {
  String categoryId;
  int count;

  CategoryId({@required this.categoryId, @required this.count});
}
