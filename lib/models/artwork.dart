import 'package:flutter/foundation.dart';
import './museum.dart';

class Artwork with ChangeNotifier{
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String author;
  final String museum;
  final String category;
  bool isFavorite;

  Artwork({
  @required this.id,
  @required this.name,
  this.imageUrl,
  this.description,
  this.author,
  @required this.museum,
  @required this.category,
  this.isFavorite = false
  });
 
void toggleFavorite(){
  isFavorite = !isFavorite;
  notifyListeners();
}

}