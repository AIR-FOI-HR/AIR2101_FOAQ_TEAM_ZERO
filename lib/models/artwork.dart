import 'package:flutter/foundation.dart';
import './museum.dart';

class Artwork with ChangeNotifier{
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String author;
  final String museum;
  bool isFavorite;

  Artwork({
  @required this.id,
  @required this.name,
  @required this.imageUrl,
  this.description,
  this.author,
  @required this.museum,
  this.isFavorite = false
  //@required this.category
  });
 
void toggleFavorite(){
  isFavorite = !isFavorite;
  notifyListeners();
}

}