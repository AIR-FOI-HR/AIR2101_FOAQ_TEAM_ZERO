import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class EditAddArtworksScreen extends StatelessWidget {
  static const routeName ='/add-edit-artworks';

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);

    return Scaffold(
      appBar: appBar('Add/edit artwork', context, color.primaryColor),
    );
  }
}