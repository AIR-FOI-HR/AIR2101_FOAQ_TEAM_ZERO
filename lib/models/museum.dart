import 'package:flutter/foundation.dart';
class Museum with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final String address;
  final double tourDuration;
  final String imageUrl;
  final String location;

  //only id and name are required. If sys admin creates new museum he only has to give museum the name.
  //museum admin can then add other info about the museum
  Museum({
    @required this.id,
    @required this.name,
    this.description,
    this.address,
    this.tourDuration,
    this.imageUrl,
    this.location,
  });
}
