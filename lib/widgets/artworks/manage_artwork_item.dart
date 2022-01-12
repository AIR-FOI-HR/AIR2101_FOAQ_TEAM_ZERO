import 'package:flutter/material.dart';
import '../../screens/artworks/edit_add_artworks_screen.dart';

class ManageArtworkItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ManageArtworkItem(this.id, this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditAddArtworksScreen.routeName);
                }),
            IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () {
                  //to do on delete
                }),
          ],
        ),
      ),
    );
  }
}