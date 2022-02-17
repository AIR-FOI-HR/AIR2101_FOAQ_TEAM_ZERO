import 'package:flutter/material.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/museum_owner/add_owner_screen.dart';
import 'package:museum_app/widgets/homepage/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
//import 'dart:html' as html;
import '../../providers/artworks.dart';
import '../../providers/users.dart';
import '../../models/museum.dart';
import '../../models/user.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museum_owners/museum_owners.dart';

import '../../widgets/artworks/manage_artwork_item.dart';
import '../../widgets/error_dialog.dart';

class ManageMuseumOwnersScreen extends StatefulWidget {
  static const routeName = '/museum_owners';

  @override
  State<ManageMuseumOwnersScreen> createState() => _ManageMuseumOwnersScreen();
}

class _ManageMuseumOwnersScreen extends State<ManageMuseumOwnersScreen> {
  bool _isLoading = false;
  bool _isFetched = false;

  //-for search-//
  List<User> ownersList;
  //-----------//

  // @override
  // void didChangeDependencies() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   setState(() {
  //     _isLoading = false;
  //   });

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    final muzeji = Provider.of<Museums>(context, listen: false);
    ownersList = Provider.of<Users>(context, listen: false).museumOwners();
    User appUser = Provider.of<Users>(context).getUser();

    return Scaffold(
      appBar: appBar(
          'Museum owners', context, Theme.of(context).primaryColor, appUser),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: FutureBuilder(
            future: _isFetched ? null : _fetchData(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  _isFetched) {
                return GroupedListView<User, String>(
                  shrinkWrap: true,
                  elements: ownersList,
                  groupBy: (user) => user.museumId,
                  groupSeparatorBuilder: (String groupByValue) => (Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          muzeji.getById(groupByValue).name,
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
                  itemBuilder: (_, user) => Column(
                    children: [
                      ManageMuseumOwners(user.id, user.name, user.surname),
                      Divider(
                        thickness: 0.2,
                        color: Colors.black,
                      )
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.highlightColor,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(addMuseumOwnerscreen.routeName);
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      drawer: MainMenuDrawer(),
    );
  }

  Future<void> _fetchData() async {
    await Provider.of<Users>(context, listen: false).fetchUsers();
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isFetched = true;
    });
  }
}
