import 'package:flutter/material.dart';
//tomekovo
class CategoryArtworkScreen extends StatelessWidget {
  static const routeName = '/categoryArtwork';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Museum app'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Text('halp'),
    );
  }
}
