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
    _artworks.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("artworks").get();

    for (var doc in querySnapshot.docs) {
      loadedArtworks.add(Artwork.fromSnap(doc));
    }
    _artworks = loadedArtworks;
    notifyListeners();
  }

  Future<void> fetchAndSetArtworks() async {
    try {
      final response = await http.get(urlArtworks);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Artwork> loadedArtworks = [];
      extracedData.forEach((id, artwork) {
        print('Dohvacam artwork');
        loadedArtworks.add(Artwork(
            id: id,
            category: artwork['category'],
            imageUrl: artwork['imageUrl'],
            museum: artwork['museum'],
            name: artwork['name'],
            author: artwork['author'],
            description: artwork['description'],
            isFavorite: false));
      });
      _artworks = loadedArtworks;
    } catch (error) {
      throw (error);
    }
  }

  List<Artwork> getByMuseumId(String id) {
    try {
      fetchAndSetArtworks();
    } catch (error) {
      throw (error);
    }
    return _artworks.where((artwork) => artwork.museum == id).toList();
  }

  List<Artwork> getByCategory(String categoryId) {
    return _artworks
        .where((artwork) => artwork.category == categoryId)
        .toList();
  }

  Artwork getById(String id) {
    try {
      fetchAndSetArtworks();
    } catch (error) {
      throw (error);
    }
    return _artworks.firstWhere((artwork) => artwork.id == id);
  }

  // List<Artwork> getByCategory(String categoryId) {
  //   try {
  //     fetchAndSetArtworks();
  //   } catch (error) {
  //     throw (error);
  //   }
  //   return _artworks
  //       .where((artwork) => artwork.category == categoryId)
  //       .toList();
  // }

  Future<void> addArtwork(Artwork artwork) async {
    try {
      final response = await http.post(urlArtworks,
          body: json.encode({
            'name': artwork.name,
            'imageUrl': artwork.imageUrl,
            'description': artwork.description,
            'author': artwork.author,
            'museum': artwork.museum,
            'category': artwork.category
          }));

      final newArtwork = Artwork(
        category: artwork.category,
        museum: artwork.museum,
        name: artwork.name,
        author: artwork.author,
        description: artwork.description,
        imageUrl: artwork.imageUrl,
        id: json.decode(response.body)['name'],
      );

      print('New artwork: ' + json.decode(response.body)['name']);
      _artworks.add(newArtwork);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateArtwork(String id, Artwork newArtwork) async {
    final artworkIndex = _artworks.indexWhere((artwork) => artwork.id == id);
    if (artworkIndex >= 0) {
      try {
        final url = Uri.parse(
            'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks/$id.json');
        await http.patch(url,
            body: json.encode({
              'author': newArtwork.author,
              'category': newArtwork.category,
              'description': newArtwork.description,
              'imageUrl': newArtwork.imageUrl,
              'museum': newArtwork.museum,
              'name': newArtwork.name
            }));
        _artworks[artworkIndex] = newArtwork;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {}
  }

  Future<void> deleteArtwork(String id) {
    //to do -> optimistic deletion and error handling
    final url = Uri.parse(
        'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks/$id.json');
    http.delete(url);
    _artworks.removeWhere((artwork) => artwork.id == id);
    notifyListeners();
  }
}
