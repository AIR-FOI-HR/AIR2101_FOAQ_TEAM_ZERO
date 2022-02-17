import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';
import '../../screens/museum_owner/museum_owner_screen.dart';
import '../../providers/artworks.dart';

class ManageMuseumOwners extends StatelessWidget {
  final String id;
  final String name;
  final String surname;

  ManageMuseumOwners(this.id, this.name, this.surname);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name + " " + surname),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
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
                          Text('Do you want to remove owner: '),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${name}',
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted museum owner: ' + name),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context)
                            .pushNamed(ManageMuseumOwnersScreen.routeName);
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
