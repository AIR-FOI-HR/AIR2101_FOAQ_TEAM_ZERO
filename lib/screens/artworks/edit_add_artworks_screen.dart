import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../models/artwork.dart';
import '../../providers/artworks.dart';

class EditAddArtworksScreen extends StatefulWidget {
  static const routeName = '/add-edit-artworks';

  @override
  State<EditAddArtworksScreen> createState() => _EditAddArtworksScreenState();
}

class _EditAddArtworksScreenState extends State<EditAddArtworksScreen> {
  bool _isInit = true;
  var _artwork = Artwork(
      id: null,
      category: '',
      imageUrl: '',
      museum: '',
      name: '',
      author: '',
      description: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final artworkId = ModalRoute.of(context).settings.arguments as String;
      if (artworkId != null) {
        _artwork = Provider.of<Artworks>(context).getById(artworkId);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData color = Theme.of(context);
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
              child: ListView(children: [
                TextFormField(
                  decoration: inputDecoration('Name', Icons.text_fields, color),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: inputDecoration('Author', Icons.person, color),
                  
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration:
                      inputDecoration('Description', Icons.description, color),
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                        child: Image.asset('assets/images/NoArtworks.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                        child: TextFormField(
                      decoration: inputDecoration('Image URL', Icons.image, color),
                      keyboardType: TextInputType.url,
                    ))
                  ],
                ),
              ])),
        ));
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



/*new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: 'Tell us about yourself',
                      helperText: 'Keep it short, this is just a demo.',
                      labelText: 'Life story',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      prefixText: ' ',
                      suffixText: 'USD',
                      suffixStyle: const TextStyle(color: Colors.green)), */