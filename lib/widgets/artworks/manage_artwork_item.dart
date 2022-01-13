import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/artworks/edit_add_artworks_screen.dart';
import '../../providers/artworks.dart';

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
        backgroundImage: NetworkImage(imageUrl != '' ? imageUrl : 'https://miro.medium.com/max/800/1*hFwwQAW45673VGKrMPE2qQ.png'),
        radius: 35,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditAddArtworksScreen.routeName, arguments: id);
                }),
            IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () {
                  Provider.of<Artworks>(context, listen: false).deleteArtwork(id);
                }),
          ],
        ),
      ),
    );
  }
}