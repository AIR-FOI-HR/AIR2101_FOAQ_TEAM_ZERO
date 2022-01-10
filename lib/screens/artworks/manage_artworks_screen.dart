import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class ManageArtworksScreen extends StatelessWidget {
  static const routeName ='/artworks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Artworks', context, Theme.of(context).primaryColor),
    );
  }
}