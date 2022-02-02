import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/screens/artworks/manage_artworks_screen.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';

import '../../widgets/error_dialog.dart';
import '../../widgets/app_bar.dart';
import '../../models/artwork.dart';
import '../../providers/artworks.dart';
import '../../providers/museums.dart';
import '../../providers/categories.dart';

class EditAddArtworksScreen extends StatefulWidget {
  static const routeName = '/add-edit-artworks';

  @override
  State<EditAddArtworksScreen> createState() => _EditAddArtworksScreenState();
}

class _EditAddArtworksScreenState extends State<EditAddArtworksScreen> {
  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'name': '',
    'museum': '',
    'category': '',
    'description': '',
    'imageUrl': '',
    'author': ''
  };
  var _artwork = Artwork(
      id: null,
      category: '',
      imageUrl: '',
      museum: '',
      name: '',
      author: '',
      description: '');
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
        _artwork = Provider.of<Artworks>(context).getById(artworkId);
        _initValues = {
          'name': _artwork.name,
          'museum': _artwork.museum,
          'category': _artwork.category,
          'description': _artwork.description,
          'imageUrl': '',
          'author': _artwork.author
        };
        _imageUrlController.text = _artwork.imageUrl;
        print('Museum id ' + _artwork.museum);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
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
      appBar: appBar(_artwork.id != null ? _artwork.name : 'Add artwork',
          context, color.primaryColor, appUser),
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
                        _artwork = Artwork(
                          id: _artwork.id,
                          name: value,
                          museum: _artwork.museum,
                          category: _artwork.category,
                          author: _artwork.author,
                          description: _artwork.description,
                          imageUrl: _artwork.imageUrl,
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    DropDownField(
                      value: _initValues['museum'] != ''
                          ? museumsMap[_initValues['museum']].toString()
                          : null,
                      textStyle:
                          TextStyle(fontSize: 16, color: color.primaryColor),
                      labelStyle:
                          TextStyle(fontSize: 16, color: color.primaryColor),
                      icon: Icon(Icons.museum, color: color.primaryColor),
                      enabled: true,
                      required: true,
                      labelText: 'Museum',
                      setter: (value) {
                        _artwork = Artwork(
                          id: _artwork.id,
                          name: _artwork.name,
                          museum: museumsMap.keys
                              .firstWhere((key) => museumsMap[key] == value),
                          category: _artwork.category,
                          author: _artwork.author,
                          description: _artwork.description,
                          imageUrl: _artwork.imageUrl,
                        );
                      },
                      items: museumsMap.values.toList(),
                      onValueChanged: (value) {
                        setState(() {
                          museum = museumsMap.keys
                              .firstWhere((key) => museumsMap[key] == value);
                          print(museum);
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    DropDownField(
                      value: _initValues['category'] != ''
                          ? categoryMap[_initValues['category']].toString()
                          : null,
                      textStyle:
                          TextStyle(fontSize: 16, color: color.primaryColor),
                      labelStyle:
                          TextStyle(fontSize: 16, color: color.primaryColor),
                      icon: Icon(Icons.category, color: color.primaryColor),
                      labelText: 'Category',
                      required: true,
                      enabled: true,
                      items: categoryMap.values.toList(),
                      setter: (value) {
                        _artwork = Artwork(
                          id: _artwork.id,
                          name: _artwork.name,
                          museum: _artwork.museum,
                          category: categoryMap.keys
                              .firstWhere((key) => categoryMap[key] == value),
                          author: _artwork.author,
                          description: _artwork.description,
                          imageUrl: _artwork.imageUrl,
                        );
                      },
                      onValueChanged: (value) {
                        setState(() {
                          category = categoryMap.keys
                              .firstWhere((key) => categoryMap[key] == value);
                          print(category);
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: _initValues['author'],
                      decoration:
                          inputDecoration('Author', Icons.person, color),
                      onSaved: (value) {
                        _artwork = Artwork(
                          id: _artwork.id,
                          name: _artwork.name,
                          museum: _artwork.museum,
                          category: _artwork.category,
                          author: value,
                          description: _artwork.description,
                          imageUrl: _artwork.imageUrl,
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: inputDecoration(
                          'Description', Icons.description, color),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _artwork = Artwork(
                          id: _artwork.id,
                          name: _artwork.name,
                          museum: _artwork.museum,
                          category: _artwork.category,
                          author: _artwork.author,
                          description: value,
                          imageUrl: _artwork.imageUrl,
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: color.highlightColor,
                            ),
                          ),
                          child: FittedBox(
                            child: _imageUrlController.text.isEmpty
                                ? Image.network(
                                    'https://images.assetsdelivery.com/compings_v2/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016.jpg')
                                : Image.network(_imageUrlController.text),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //initialValue: _initValues['imageUrl'],
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            //this controller helps us refresh image
                            decoration: inputDecoration(
                                'Image URL', Icons.image, color),
                            validator: (value) {
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https') &&
                                  value != '') {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            onSaved: (value) {
                              _artwork = Artwork(
                                id: _artwork.id,
                                name: _artwork.name,
                                museum: _artwork.museum,
                                category: _artwork.category,
                                author: _artwork.author,
                                description: _artwork.description,
                                imageUrl: value,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              backgroundColor: color.highlightColor,
              onPressed: _saveArtwork,
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

  Future<void> _saveArtwork() async {
    final formIsValid = _formKey.currentState.validate();
    if (!formIsValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_artwork.id != null) {
      try {
        await DBCaller.updateArtwork(_artwork);
      } catch (error) {
        print(error);
        await showErrorDialog(context);
      }
    } else {
      try {
        print(_artwork.imageUrl);
        await DBCaller.addArtwork(_artwork);
      } catch (error) {
        await showErrorDialog(context);
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).popAndPushNamed(ManageArtworksScreen.routeName);
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
