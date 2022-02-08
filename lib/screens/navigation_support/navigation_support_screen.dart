import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class NavigationSupportScreen extends StatelessWidget {
  static const routeName = '/navigationSupport';
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final appBarProperty =
        appBar('Naviagtion support', context, color.primaryColor);

    return Scaffold(
      appBar: appBarProperty,
      body: Text('Too doo'),
    );
  }
}
