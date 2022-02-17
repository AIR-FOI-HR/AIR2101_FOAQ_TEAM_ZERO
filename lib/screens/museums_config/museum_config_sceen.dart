import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/museum_staff/museum_staff_adding_screen.dart';
import 'package:museum_app/screens/museums_config/museums_edit_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/museums.dart';
import '../../models/museum.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/museums_config/museums_config_show.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museumStaff/museumStaff.dart';
import '../../widgets/error_dialog.dart';

class ManageMuseums extends StatefulWidget {
  static const routeName = '/museums_config';

  @override
  State<ManageMuseums> createState() => _ManageMuseums();
}

class _ManageMuseums extends State<ManageMuseums> {
  List<Museum> MuseumsList;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });

    MuseumsList = Provider.of<Museums>(context).getMuseums;

    setState(() {
      _isLoading = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();

    final appBarProperty = appBar(
        'Museum config', context, Theme.of(context).primaryColor, appUser);
    ThemeData color = Theme.of(context);
    List<Museum> museums = Provider.of<Museums>(context).getMuseums;

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, i) => Column(
                children: [
                  Divider(
                    thickness: 2,
                    color: color.highlightColor,
                  ),
                  MuseumsConfig(
                      museums[i].id, museums[i].name, museums[i].imageUrl),
                ],
              ),
              itemCount: museums.length,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.highlightColor,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditAddMuseumsScreen.routeName);
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
