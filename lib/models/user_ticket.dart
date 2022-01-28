import 'package:flutter/cupertino.dart';

class UserTicket {
  final String ticketId;
  final String billId;
  final int quantity;

  UserTicket({
    @required this.ticketId,
    @required this.billId,
    @required this.quantity,
  });
}
