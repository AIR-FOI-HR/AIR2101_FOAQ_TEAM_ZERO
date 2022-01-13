import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/artwork.dart';
import '../models/museum.dart';
import '../providers/museums.dart';


class Artworks with ChangeNotifier {

  final urlArtworks = Uri.parse('https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks.json');

  List<Artwork> _artworks = [];
  
  List<Artwork> get getArtworks{
    return [..._artworks];
  }

  Future<void> fetchAndSetArtwotks() async{
    try{
      final response = await http.get(urlArtworks);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Artwork> loadedArtworks = [];
      print('Baza: '+ extracedData.length.toString());
      print('Lokalno: '+ _artworks.length.toString());
      if(extracedData.length == _artworks.length){
        return;
      }
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
          isFavorite: false
        ));
      });
      _artworks = loadedArtworks;
    }catch(error){
      throw(error);
    }
  }
  
  List<Artwork> getByMuseumId(String id) {
    return _artworks.where((artwork) => artwork.museum == id).toList();
  }

  Artwork getById(String id){
    return _artworks.firstWhere((artwork) => artwork.id == id);
  }

  List<Artwork> getByCategory(String categoryId){
    return _artworks.where((artwork) => artwork.category == categoryId).toList();
  }

//   Future<void> addArtworks() async{
//     for (Artwork artwork in _artworks) {
//       try{
//         await http.post(urlArtworks, body: json.encode({
//           'name': artwork.name,
//           'imageUrl':artwork.imageUrl,
//           'description':artwork.description,
//           'author':artwork.author,
//           'museum':artwork.museum,
//           'category':artwork.category
//         }));
//       }catch(error){
//         print(error);
//       }
//     }
//     print('Uspjesno prebaceni podaci u bazu');
//   }
}
