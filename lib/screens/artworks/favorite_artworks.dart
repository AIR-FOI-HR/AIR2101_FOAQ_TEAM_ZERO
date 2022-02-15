import 'package:flutter/material.dart';
import 'package:museum_app/models/artwork.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:museum_app/widgets/favorite_artworks/favorite_artworks_grid.dart';
import 'package:museum_app/widgets/homepage/search_bar.dart';
import 'package:museum_app/widgets/main_menu_drawer.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';

class FavoriteArtworks extends StatefulWidget {
  static const routeName = '/favoriteArtworks';
  @override
  _FavoriteArtworksState createState() => _FavoriteArtworksState();
}

class _FavoriteArtworksState extends State<FavoriteArtworks> {
  List<Artwork> artworksForWidget = [];
  List<Artwork> mainArtworksList = [];
  String query = '';

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    return Scaffold(
      appBar: appBar('Favorite artworks', context,
          Theme.of(context).highlightColor, appUser),
      body: appUser.favoriteArtworks.isEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/NoArtworks.png',
                fit: BoxFit.fill,
              ))
          : RefreshIndicator(
              onRefresh: _fetchArtworks,
              child: FutureBuilder(
                  future: mainArtworksList.isEmpty ? _fetchArtworks() : null,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        mainArtworksList.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SearchBar(searchArtworks),
                              ],
                            ),
                            FavoriteArtworksGrid(artworksForWidget),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
      drawer: MainMenuDrawer(),
    );
  }

  void searchArtworks(String queryy) {
    setState(() {
      query = queryy;
      artworksForWidget = mainArtworksList.where((artwork) {
        final titleLower = artwork.name.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _fetchArtworks() async {
    //While waiting for data from database we wait 0.5 seconds. This is for better UX and smoothness
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    await Provider.of<Artworks>(context, listen: false).fetchArtworks();
    await Provider.of<Museums>(context, listen: false).fetchMuseums();
    await Future.delayed(const Duration(milliseconds: 700));
    mainArtworksList = Provider.of<Artworks>(context, listen: false)
        .getUserFavoriteArtworks(appUser.favoriteArtworks);
    setState(() {
      artworksForWidget = mainArtworksList;
    });
  }
}
