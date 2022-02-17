import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
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
bool _isLoading = false;

@override
void didChangeDependencies() async {
  setState(() {
    _isLoading = true;
  });
  
    mainArtworksList =
        Provider.of<Users>(context).workInMuseum('2');
    
  setState(() {
    _isLoading = false;
  });


  super.didChangeDependencies();
}

  @override
  Widget build(BuildContext context) {
    final appBarProperty = appBar('Museum staff', context, Theme.of(context).primaryColor);
    ThemeData color = Theme.of(context);
    List<User> staff = Provider.of<Users>(context).workInMuseum("2");

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: 
      _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  
                ListView.builder(
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