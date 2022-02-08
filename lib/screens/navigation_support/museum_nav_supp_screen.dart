import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class MuseumNavSuppScreen extends StatelessWidget {
  static const routeName = '/museumNavSupp';

  @override
  Widget build(BuildContext context) {
    final museumId = ModalRoute.of(context).settings.arguments as String;
    final color = Theme.of(context);
    return Scaffold(
      appBar: appBar('Navigation support', context, color.primaryColor),
      body: Text(museumId),
    );
  }
}
