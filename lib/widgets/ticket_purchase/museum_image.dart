import 'package:flutter/material.dart';

class MuseumImage extends StatelessWidget {
  String imageUrl;

  MuseumImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Image.asset(
        imageUrl,
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }
}
