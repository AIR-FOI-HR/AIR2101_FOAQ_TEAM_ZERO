//import 'dart:html';
import 'package:museum_app/screens/museums_config/museums_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/screens/museums_config/museum_config_sceen.dart';

class MuseumsConfig extends StatelessWidget {
  final String id;
  final String ime;
  final String imageURL;

  MuseumsConfig(this.id, this.ime, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL != ''
            ? imageURL
            : 'https://miro.medium.com/max/800/1*hFwwQAW45673VGKrMPE2qQ.png'),
      ),
      title: Text(
        ime,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditAddMuseumsScreen.routeName, arguments: id);
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
                          Text('Do you want to remove museum: '),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${ime}',
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
                        Provider.of<Museums>(context, listen: false)
                            .deleteMuseums(id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted museum: ' + ime),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context)
                            .pushNamed(ManageMuseums.routeName);
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
