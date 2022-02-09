import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../models/artwork.dart';

class ComplicatedImageDemo extends StatefulWidget {
  final List<Artwork> artworkList;

  ComplicatedImageDemo(this.artworkList);

  @override
  State<ComplicatedImageDemo> createState() => _ComplicatedImageDemoState();
}

class _ComplicatedImageDemoState extends State<ComplicatedImageDemo> {
  List<Artwork> selectedCategory;

  void initState() {
    selectedCategory = widget.artworkList;
    super.initState();
  }

  List<Widget> imageSlider() {
    return selectedCategory
        .map((item) => Container(
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.imageUrl,
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSlider(),
    );
  }
}
