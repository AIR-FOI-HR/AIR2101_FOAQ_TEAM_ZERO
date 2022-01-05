import 'package:flutter/foundation.dart';
import './museum.dart';

class Artwork with ChangeNotifier{
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String author;
  final Museum museum;
  //final Category category;

  Artwork({
  @required this.id,
  @required this.name,
  @required this.imageUrl,
  this.description,
  this.author,
  @required this.museum,
  //@required this.category
  });
 
//After creating category model include category as property of artwork

}