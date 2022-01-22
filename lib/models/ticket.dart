import 'package:flutter/foundation.dart';

class Ticket {
  final String id;
  final String name;
  final double cost;
  final String museumId;

  Ticket({
    @required this.id,
    @required this.name,
    @required this.cost,
    @required this.museumId,
  });
}
