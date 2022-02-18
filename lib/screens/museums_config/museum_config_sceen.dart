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
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _fetchData() async {
      await Provider.of<Museums>(context, listen: false).fetchMuseums();
      await Future.delayed(const Duration(milliseconds: 700));
      _isFetched = true;
    }

    User appUser = Provider.of<Users>(context).getUser();
    final appBarProperty = appBar(
        'Museum config', context, Theme.of(context).primaryColor, appUser);
    ThemeData color = Theme.of(context);

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: FutureBuilder(
          future: _isFetched ? null : _fetchData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                _isFetched) {
              List<Museum> museums = Provider.of<Museums>(context).getMuseums;
              return ListView.builder(
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
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
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
