import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../providers/artworks.dart';
import '../../providers/museums.dart';
import '../../models/artwork.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/artworks/manage_artwork_item.dart';

import './edit_add_artworks_screen.dart';

class ManageArtworksScreen extends StatefulWidget {
  static const routeName = '/artworks';

  @override
  State<ManageArtworksScreen> createState() => _ManageArtworksScreenState();
}

class _ManageArtworksScreenState extends State<ManageArtworksScreen> {
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Artworks>(context).fetchAndSetArtworks().catchError((error) {
        return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!',style: TextStyle(color: Colors.black),),
            content: Text('Oops, something went wrong..'),

            actions: [
              TextButton(onPressed: (){
                Navigator.of(ctx).pop();
              }, child: Text('Okay',style: TextStyle(backgroundColor: Colors.white),),),
            ],
          ),
        );
      }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    final artworks = Provider.of<Artworks>(context);
    final museums = Provider.of<Museums>(context);

    return Scaffold(
        appBar: appBar('Artworks', context, Theme.of(context).primaryColor),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GroupedListView<Artwork, String>(
                elements: artworks.getArtworks,
                groupBy: (artwork) => artwork.museum,
                groupSeparatorBuilder: (String groupByValue) => (Padding(
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
                    ManageArtworkItem(
                      artwork.id,
                      artwork.name,
                      artwork.imageUrl,
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
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
}
