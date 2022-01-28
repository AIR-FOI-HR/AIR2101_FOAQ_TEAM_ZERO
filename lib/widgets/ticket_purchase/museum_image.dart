import 'package:flutter/material.dart';

class MuseumImage extends StatelessWidget {
  String imageUrl;

  MuseumImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      height: 170,
      fit: BoxFit.fill,
    );
  }
}
