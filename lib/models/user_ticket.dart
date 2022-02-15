import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserTicket with ChangeNotifier {
  final String ticketId;
  String billId;
  final int quantity;

  UserTicket({
    @required this.ticketId,
    @required this.billId,
    @required this.quantity,
  });

  static UserTicket fromSnap(QueryDocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserTicket(
      ticketId: snapshot["ticket"],
      billId: snapshot["bill"],
      quantity: snapshot["qty"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ticket": ticketId,
        "bill": billId,
        "qty": quantity,
      };
}
