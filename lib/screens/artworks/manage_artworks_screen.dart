import 'package:flutter/material.dart';
import 'package:museum_app/main.dart';
import 'package:museum_app/providers/categories.dart';
import 'package:museum_app/widgets/homepage/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../providers/artworks.dart';
import '../../providers/museums.dart';
import '../../models/artwork.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/artworks/manage_artwork_item.dart';
import '../../widgets/error_dialog.dart';
import '../../models/user.dart';
import '../../providers/users.dart';
import './edit_add_artworks_screen.dart';

class ManageArtworksScreen extends StatefulWidget {
  static const routeName = '/artworks';
  User appUser;
  @override
  State<ManageArtworksScreen> createState() => _ManageArtworksScreenState();
}

class _ManageArtworksScreenState extends State<ManageArtworksScreen> {
  List<Artwork> artworksForWidget = [];
  List<Artwork> mainArtworksList = [];
  String query = '';

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    final museums = Provider.of<Museums>(context);
    User appUser = Provider.of<Users>(context).getUser();

    return Scaffold(
        appBar: appBar(
            'Artworks', context, Theme.of(context).primaryColor, appUser),
        body: FutureBuilder(
            future: mainArtworksList.isEmpty ? _fetchArtworks() : null,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  mainArtworksList.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SearchBar(searchArtworks),
                      artworksForWidget.isNotEmpty
                          ? GroupedListView<Artwork, String>(
                              shrinkWrap: true,
                              elements: artworksForWidget,
                              groupBy: (artwork) => artwork.museum,
                              groupSeparatorBuilder: (String groupByValue) =>
                                  (Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      museums.getById(groupByValue).name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: color.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: color.highlightColor,
                                    ),
                                  ],
                                ),
                              )),
                              itemBuilder: (_, artwork) => Column(
                                children: [
                                  ManageArtworkItem(artwork.id, artwork.name,
                                      artwork.imageUrl, refreshArtworks),
                                  Divider(
                                    thickness: 0.2,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )
                          : Image.asset(
                              'assets/images/NoArtworks.png',
                              fit: BoxFit.fill,
                            ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color.highlightColor,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditAddArtworksScreen.routeName);
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        drawer: MainMenuDrawer());
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
    Provider.of<Artworks>(context, listen: false).fetchArtworks();
    Provider.of<Categories>(context, listen: false).fetchCategories();
    await Future.delayed(Duration(milliseconds: 1000));
    mainArtworksList =
        Provider.of<Artworks>(context, listen: false).getArtworks;
    artworksForWidget = mainArtworksList;
  }

  void refreshArtworks(String callback) {
    mainArtworksList.removeWhere((artwork) => artwork.id == callback);
    setState(() {
      artworksForWidget = mainArtworksList;
    });
  }
}
