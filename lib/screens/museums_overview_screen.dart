import 'package:flutter/material.dart';
import '../widgets/homepage/museums_grid.dart';

class MuseumsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Museums'),
      ),
      body: MuseumsGrid(),
    );
  }
}
