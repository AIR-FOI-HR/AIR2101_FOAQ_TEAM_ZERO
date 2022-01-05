import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';

import '../providers/museums.dart';

class MuseumDetailScreen extends StatelessWidget {
  static const routeName =
      '/museum-detail'; //namedroute for pushing named from MuseumOverviewScree

  @override
  Widget build(BuildContext context) {
    final museumId = ModalRoute.of(context).settings.arguments as String; //get id when routed to  museum detail screen
    final museum = Provider.of<Museums>(context).getById(museumId); //get museum by id from Museums provider
    return Scaffold(
      appBar: appBar(museum.name, context),
    );
  }
}
