import 'package:flutter/material.dart';

class MuseumWorkTimeCrudScreen extends StatefulWidget {
  static const routeName = '/EditMuseumWorkTime';
  @override
  _MuseumWorkTimeCrudScreenState createState() =>
      _MuseumWorkTimeCrudScreenState();
}

class _MuseumWorkTimeCrudScreenState extends State<MuseumWorkTimeCrudScreen> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit work time'),
        backgroundColor: color.primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Text(ModalRoute.of(context).settings.arguments as String),
    );
  }
}
