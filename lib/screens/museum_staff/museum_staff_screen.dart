import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/screens/museum_staff/museum_staff_adding_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/users.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museumStaff/museumStaff.dart';
import '../../widgets/error_dialog.dart';

class ManageMuseumStaff extends StatefulWidget {
  static const routeName = '/museumStaff';

  @override
  State<ManageMuseumStaff> createState() => _ManageMuseumStaff();
}

class _ManageMuseumStaff extends State<ManageMuseumStaff> {
  List<User> mainArtworksList;
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _fetchData() async {
      await Provider.of<Users>(context, listen: false).fetchUsers();
      await Provider.of<Museums>(context, listen: false).fetchMuseums();
      await Future.delayed(const Duration(milliseconds: 700));
      setState(() {
        _isFetched = true;
      });
    }

    User appUser = Provider.of<Users>(context).getUser();
    mainArtworksList =
        Provider.of<Users>(context, listen: false).workInMuseum('2');

    final appBarProperty = appBar(
        'Museum staff', context, Theme.of(context).primaryColor, appUser);
    ThemeData color = Theme.of(context);
    List<User> staff =
        Provider.of<Users>(context).workInMuseum(appUser.museumId);

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: FutureBuilder(
          future: _isFetched ? null : _fetchData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                _isFetched) {
              return ListView.builder(
                itemBuilder: (_, i) => Column(
                  children: [
                    Divider(
                      thickness: 2,
                      color: color.highlightColor,
                    ),
                    MuseumStaff(
                      staff[i].id,
                      staff[i].name,
                      staff[i].surname,
                      staff[i].phoneNumber,
                    ),
                  ],
                ),
                itemCount: staff.length,
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.highlightColor,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(addStaff.routeName);
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
