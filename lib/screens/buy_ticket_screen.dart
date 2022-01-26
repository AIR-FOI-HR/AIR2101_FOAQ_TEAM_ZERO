import 'package:flutter/material.dart';
import '../../providers/users.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar.dart';

class BuyTicketScreen extends StatelessWidget {
  static const routeName="/buy-tickets";
   //namedroute for buy ticket screen
  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    return Scaffold(
      appBar: appBar('Buy tickets', context, Theme.of(context).primaryColor,appUser)
    );
  }
}