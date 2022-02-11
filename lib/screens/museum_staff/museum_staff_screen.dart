import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:provider/provider.dart';
import '../../providers/users.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museumStaff/museumStaff.dart';

class ManageMuseumStaff extends StatelessWidget {
  static const routeName = '/museumStaff';
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final appBarProperty = appBar('Museum staff', context, Theme.of(context).primaryColor);
    ThemeData color = Theme.of(context);
    List<User> staff = Provider.of<Users>(context).workInMuseum("2");

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: ListView.builder(
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
              ),
        
            ],
            
            ),
            
            itemCount: staff.length,

                  
          ),
          

        
          
      
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.highlightColor,
        child: IconButton(
          onPressed: () {
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