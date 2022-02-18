//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/museum_staff/museum_staff_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class MuseumStaff extends StatelessWidget {
  final String id;
  final String ime;
  final String prezime;
  final String phone;

  MuseumStaff(this.id, this.ime, this.prezime,this.phone);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        ime + " " + prezime,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.call, color: Theme.of(context).primaryColor),
                onPressed: () {
                  launch(('tel://${phone}'));
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
                          Text('Do you want to remove staff: '),
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
                      onPressed: () async {
                        Navigator.of(ctx).pop(true);
                        User user = Provider.of<Users>(context, listen: false)
                            .findById(id);
                        user.museumId = '';
                        user.userRole = '1';
                        await DBCaller.updateUser(user);
                        Provider.of<Users>(context, listen: false)
                            .deleteStaff(id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted staff: ' + ime),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context)
                            .pushNamed(ManageMuseumStaff.routeName);
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
