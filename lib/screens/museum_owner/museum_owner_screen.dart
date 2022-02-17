import 'package:flutter/material.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/museum_owner/add_owner_screen.dart';
import 'package:museum_app/widgets/homepage/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'dart:html'as html;
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

  //-for search-//
  List<User> ownersList;
  //-----------//

  @override
  void didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });
        ownersList = Provider.of<Users>(context, listen: false).museumOwners();

      
      setState(() {
        _isLoading = false;
      });
    

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    final muzeji = Provider.of<Museums>(context, listen: false);

    return Scaffold(
        appBar: appBar('Museum owners', context, Theme.of(context).primaryColor),
        body: 
                   GroupedListView<User, String>(
                            shrinkWrap: true,
                            elements: ownersList,
                            groupBy: (user) => user.museumId,
                            groupSeparatorBuilder: (String groupByValue) =>
                                (Padding(
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
                                ManageMuseumOwners(
                                  user.id,
                                  user.name,
                                  user.surname
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
              Navigator.of(context).pushNamed(addMuseumOwnerscreen.routeName);
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
