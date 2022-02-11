import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket with ChangeNotifier {
  final String id;
  final String name;
  final String cost;
  final String museumId;

  Ticket({
    @required this.id,
    @required this.name,
    @required this.cost,
    @required this.museumId,
  });

  static Ticket fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Ticket(
        id: snap.id,
        cost: snapshot["cost"],
        museumId: snapshot["museumId"],
        name: snapshot["name"]);
  }

  Map<String, dynamic> toJson() =>
      {"cost": cost, "museumId": museumId, "name": name};
}
