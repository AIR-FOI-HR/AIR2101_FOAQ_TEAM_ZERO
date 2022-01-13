import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';

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
  bool _isInit = true;

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

  final selectedMuseum = TextEditingController();
  String museum = "";

  final selectedCategory = TextEditingController();
  String category = "";

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
          'imageUrl': _artwork.imageUrl,
          'author': _artwork.author
        };
        print('Museum id ' + _artwork.museum);
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
        _artwork.id != null ? _artwork.name : 'Add artwork',
        context,
        color.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 12),
              TextFormField(
                initialValue: _initValues['name'],
                decoration: inputDecoration('Name', Icons.text_fields, color),
              ),
              SizedBox(height: 12),
              DropDownField(
                value: _initValues['museum'] != '' ? museumsMap[_initValues['museum']].toString() : null,
                textStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                labelStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                icon: Icon(Icons.museum, color: color.primaryColor),
                enabled: true,
                required: true,
                labelText: 'Museum',
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
                //controller: selectedCategory,
                value: _initValues['category'] != '' ? categoryMap[_initValues['category']].toString() : null,
                textStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                labelStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                icon: Icon(Icons.category, color: color.primaryColor),
                labelText: 'Category',
                required: true,
                enabled: true,
                items: categoryMap.values.toList(),
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
                decoration: inputDecoration('Author', Icons.person, color),
              ),
              SizedBox(height: 12),
              TextFormField(
                initialValue: _initValues['description'],
                decoration:
                    inputDecoration('Description', Icons.description, color),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
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
                      child: _initValues['imageUrl'] == ''
                          ? Image.asset('assets/images/NoArtworks.png')
                          : Image.network(_initValues['imageUrl']),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: _initValues['imageUrl'],
                    decoration:
                        inputDecoration('Image URL', Icons.image, color),
                    keyboardType: TextInputType.url,
                  ))
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
              onPressed: () {},
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
}
