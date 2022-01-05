import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';

class MuseumDetailScreen extends StatelessWidget {
  static const routeName =
      '/museum-detail'; //namedroute for pushing named from MuseumOverviewScree

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Hello', context),
    );
  }
}
