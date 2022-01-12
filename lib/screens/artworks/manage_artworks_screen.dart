import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/artworks.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/artworks/manage_artwork_item.dart';
class ManageArtworksScreen extends StatelessWidget {
  static const routeName = '/artworks';

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    final artworks = Provider.of<Artworks>(context).getArtworks;

    return Scaffold(
        appBar: appBar('Artworks', context, Theme.of(context).primaryColor),
        body: ListView.builder(
          itemCount: artworks.length,
          itemBuilder: (_, i) =>Column(children: [
            ManageArtworkItem(
              artworks[i].id,
              artworks[i].name,
              artworks[i].imageUrl
            ),
            Divider(thickness: 1, color: color.highlightColor,)
          ],),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color.highlightColor,
          child: IconButton(
            onPressed: () {
              //TO DO - reroute to add/edit artwork
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        drawer: MainMenuDrawer());
  }
}
