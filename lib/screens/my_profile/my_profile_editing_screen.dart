import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';

import '../../providers/users.dart';

class MyProfileEditingScreen extends StatelessWidget {
  static const routeName = '/myProfileEditing';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final appBarProperty = appBar('My Profile', context, color.primaryColor);
    final userDataProvider = Provider.of<Users>(context);
    return Scaffold(
      appBar: appBarProperty,
      body: Text('dada'),
    );
  }
}
