import 'package:flutter/cupertino.dart';

class MuseumHalls {
  final String id;
  final String name;
  final String description;
  final int order;
  final String museumId;
  final String categoryId;

  MuseumHalls({
    @required this.id,
    @required this.name,
    this.description,
    @required this.order,
    @required this.museumId,
    @required this.categoryId,
  });
}
