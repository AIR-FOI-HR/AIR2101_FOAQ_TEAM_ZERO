import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:collection/collection.dart';
import 'package:museum_app/models/artwork.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:provider/provider.dart';
import '../../widgets/homepage/museums_grid.dart';
import '../../widgets/homepage/search_bar.dart';
import '../../widgets/homepage/dropdown_category.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/app_bar.dart';
import '../../models/museum.dart';
import '../../models/user.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';

class MuseumsOverviewScreen extends StatefulWidget {
  @override
  State<MuseumsOverviewScreen> createState() => _MuseumsOverviewScreenState();
}

class _MuseumsOverviewScreenState extends State<MuseumsOverviewScreen> {
  List<Museum> museumsForWidget = [];
  List<Museum> mainMuseumList = [];
  List<Museum> museumsSearchSelectedCategory;
  String query = '';
  String category = 'c0';

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();

    return Scaffold(
      appBar: appBar(
          'Museum app', context, Theme.of(context).primaryColor, appUser),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
            future: mainMuseumList.isEmpty ? _fetchMuseums() : null,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  mainMuseumList.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropDownCategory(searchMuseumByCategory),
                          SearchBar(searchMuseum),
                        ],
                      ),
                      MuseumsGrid(museumsForWidget),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      drawer: MainMenuDrawer(),
    );
  }

  void searchMuseumByCategory(String categoryId) {
    setState(() {
      category = categoryId;
      if (categoryId != 'c0') {
        List<Artwork> categoryArtworks =
            Provider.of<Artworks>(context, listen: false)
                .getByCategory(categoryId);
        List<Museum> museumsFilter = [];
        for (Artwork artwork in categoryArtworks) {
          museumsFilter.add(
              mainMuseumList.firstWhereOrNull((el) => el.id == artwork.museum));
        }
        museumsForWidget = museumsFilter.toSet().toList();
        museumsSearchSelectedCategory = museumsForWidget;
      } else {
        museumsForWidget = mainMuseumList;
        museumsSearchSelectedCategory = null;
      }
    });
  }

  void searchMuseum(String queryText) {
    setState(() {
      List<Museum> searchMuseum =
          museumsSearchSelectedCategory ?? mainMuseumList;
      query = queryText;
      museumsForWidget = searchMuseum.where((museum) {
        final titleLower = museum.name.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _fetchMuseums() async {
    //While waiting for data from database we wait 0.5 seconds. This is for better UX and smoothness
    await Provider.of<Museums>(context, listen: false).fetchMuseums();
    await Provider.of<Artworks>(context, listen: false).fetchArtworks();
    await Future.delayed(const Duration(milliseconds: 700));
    mainMuseumList = Provider.of<Museums>(context, listen: false).getMuseums;
    museumsForWidget = mainMuseumList;
  }

  Future<void> _refresh() async {
    await Provider.of<Museums>(context, listen: false).fetchMuseums();
    await Provider.of<Artworks>(context, listen: false).fetchArtworks();
    await Future.delayed(const Duration(milliseconds: 1300));
    mainMuseumList = Provider.of<Museums>(context, listen: false).getMuseums;
    setState(() {
      museumsForWidget = mainMuseumList;
    });
  }
}
