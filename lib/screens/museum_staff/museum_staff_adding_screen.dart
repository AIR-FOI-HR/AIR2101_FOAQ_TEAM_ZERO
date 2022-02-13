
import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:provider/provider.dart';
import '../../providers/users.dart';


import '../../widgets/app_bar.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/museumStaff/museumStaff.dart';

class addStaff extends StatefulWidget {
  static const routeName = '/add-edit-staff';

  @override
  State<addStaff> createState() => _addStaffScreenState();
}

class _addStaffScreenState extends State<addStaff> {
  
  @override
  Widget build(BuildContext context) {
   ThemeData color = Theme.of(context);
   final _formKey = GlobalKey<FormState>();
   final appBarProperty = appBar('Add museum staff', context, Theme.of(context).primaryColor);
   bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
   return Scaffold(
     appBar: appBarProperty,
     body: Padding(padding: EdgeInsets.all(10),
     child: Form(key: _formKey,
     child: ListView(
       children: [
         SizedBox(height: 12),
         TextFormField(
           decoration: inputDecoration('Email', Icons.email, color),
           onSaved: (value){
             var email = value;
           },
           validator: (value) {
            if (value.isEmpty) {
              return 'This field cannot be empty!';
            }
            return null;
          },
         )
       ],
     ),) 
     ),
     floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              backgroundColor: color.highlightColor,
              child: IconButton(
                //onPressed: _sendEmail,
                icon: Icon(
                  Icons.check,
                  color: color.primaryColor,
                  size: 35,
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
   );

  }
  InputDecoration inputDecoration(
      String hintText, IconData icon, ThemeData color) {
    return InputDecoration(
      labelText: hintText,
      labelStyle: TextStyle(fontSize: 16, color: color.primaryColor),
      border: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(25.0)),
      prefixIcon: Icon(
        icon,
        color: color.primaryColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.highlightColor, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }

  
}