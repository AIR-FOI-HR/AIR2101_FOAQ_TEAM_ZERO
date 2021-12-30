import 'package:flutter/cupertino.dart';

class Museum {
  final String id;
  final String name;
  final String address;
  final double tourDuration;
  final String urlPath;

  Museum({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.tourDuration,
    this.urlPath,
  });
}
