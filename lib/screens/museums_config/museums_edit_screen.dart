import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/museum_staff/museum_staff_screen.dart';
import 'package:museum_app/screens/museums_config/museum_config_sceen.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';

import '../../widgets/error_dialog.dart';
import '../../widgets/app_bar.dart';
import '../../models/artwork.dart';
import '../../providers/artworks.dart';
import '../../providers/museums.dart';
import '../../providers/categories.dart';

class EditAddMuseumsScreen extends StatefulWidget {
  static const routeName = '/add-edit-museums';

  @override
  State<EditAddMuseumsScreen> createState() => _EditAddMuseumsScreen();
}

class _EditAddMuseumsScreen extends State<EditAddMuseumsScreen> {
  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'name': '',
    'address': '',
    'description': '',
    'imageUrl': '',
    'tourDuration':'',
    'location': ''
  };

  var _museum = Museum(
      id: null,
      name: '',
      address: '',
      description: '',
      tourDuration: null,
      imageUrl: '',
      location: '');

  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  String museum = "";
  String category = "";

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final artworkId = ModalRoute.of(context).settings.arguments as String;
      print(artworkId);
      if (artworkId != null) {
        _museum = Provider.of<Museums>(context).getById(artworkId);
        _initValues = {
          'name': _museum.name,
          'address': _museum.address,
          'description': _museum.description,
          'imageUrl': _museum.imageUrl,
          'tourDuration': _museum.tourDuration.toString(),
          'location': _museum.location
        };
        _imageUrlController.text = _museum.imageUrl;
        print('Museum id ' + _museum.id);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    Map<String, String> museumsMap = {};
    Provider.of<Museums>(context)
        .getMuseums
        .forEach((museum) => museumsMap[museum.id] = museum.name);

    Map<String, String> categoryMap = {};
    Provider.of<Categories>(context)
        .items
        .forEach((category) => categoryMap[category.id] = category.name);

    return Scaffold(
      appBar: appBar(
        _museum.id != null ? _museum.name : 'Add museum',
        context,
        color.primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration:
                          inputDecoration('Name', Icons.text_fields, color),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _museum = Museum(
                          id: _museum.id,
                          name: value,
                          address: _museum.address,
                          description: _museum.description,
                          tourDuration: _museum.tourDuration,
                          imageUrl: _museum.imageUrl,
                          location: _museum.location,
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: _initValues['address'],
                      decoration:
                          inputDecoration('Address', Icons.text_fields, color),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _museum = Museum(
                          id: _museum.id,
                          name: _museum.name,
                          address: value,
                          description: _museum.description,
                          tourDuration: _museum.tourDuration,
                          imageUrl: _museum.imageUrl,
                          location: _museum.location,
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration:
                          inputDecoration('Description', Icons.person, color),
                      onSaved: (value) {
                        _museum = Museum(
                          id: _museum.id,
                          name: _museum.name,
                          address: _museum.address,
                          description: value,
                          tourDuration: _museum.tourDuration,
                          imageUrl: _museum.imageUrl,
                          location: _museum.location,
                        );
                      },
                    ),
                    
                    
                  ],
                ),
              ),
            ),
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              backgroundColor: color.highlightColor,
              onPressed: _saveMuseum,
              child: IconButton(
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

  Future<void> _saveMuseum() async {
    final formIsValid = _formKey.currentState.validate();
    if (!formIsValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_museum.id != null) {
      try {
        await Provider.of<Museums>(context, listen: false)
            .updateMuseum(_museum);
      } catch (error) {
        print(error);
        await showErrorDialog(context);
      }
    } else {
      try {
        print(_museum.imageUrl);
        await Provider.of<Museums>(context, listen: false)
            .AddMuseums(_museum);
      } catch (error) {
        await showErrorDialog(context);
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(ManageMuseums.routeName);

  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {
        _imageUrlFocusNode.removeListener(_updateImageUrl);
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
  }
}
