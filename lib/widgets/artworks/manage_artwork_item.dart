import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:provider/provider.dart';
import '../../screens/artworks/edit_add_artworks_screen.dart';
import '../../providers/artworks.dart';

class ManageArtworkItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final ValueChanged<String> onChanged;

  ManageArtworkItem(this.id, this.title, this.imageUrl, this.onChanged);

  @override
  State<ManageArtworkItem> createState() => _ManageArtworkItemState();
}

class _ManageArtworkItemState extends State<ManageArtworkItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl != ''
            ? widget.imageUrl
            : 'https://miro.medium.com/max/800/1*hFwwQAW45673VGKrMPE2qQ.png'),
        radius: 35,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      EditAddArtworksScreen.routeName,
                      arguments: widget.id);
                }),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text(
                    'Are you sure?',
                    style: TextStyle(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
                  ),
                  content: Container(
                    height: 70,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Do you want to remove artwork: '),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${widget.title}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        'No',
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                        DBCaller.deleteArtwork(widget.id);
                        widget.onChanged(widget.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted Artwork: ' + widget.title),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
