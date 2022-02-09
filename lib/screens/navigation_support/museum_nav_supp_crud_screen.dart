import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';

import './museum_nav_supp_screen.dart';
import '../../models/museum_halls.dart';
import '../../providers/museums_halls.dart';
import '../../providers/categories.dart';

class MuseumNavSuppCrudScreen extends StatefulWidget {
  static const routeName = '/MuseumNavSuppCrud';
  @override
  _MuseumNavSuppCrudScreenState createState() =>
      _MuseumNavSuppCrudScreenState();
}

class _MuseumNavSuppCrudScreenState extends State<MuseumNavSuppCrudScreen> {
  final _orderFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var _editedMuseumHall = MuseumHalls(
    id: null,
    name: '',
    order: null,
    museumId: '',
    categoryId: '',
    description: '',
  );

  String category = "";

  @override
  void dispose() {
    _orderFocusNode.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'order': 0,
    'categoryId': '',
    'description': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final arguments = ModalRoute.of(context).settings.arguments as Map;
      var museumHallId = arguments['museumHallId'];
      var museumId = arguments['museumId'];
      _editedMuseumHall = MuseumHalls(
        id: null,
        name: '',
        order: null,
        museumId: museumId,
        categoryId: '',
        description: '',
      );
      if (museumHallId != null) {
        _editedMuseumHall = Provider.of<MuseumsHalls>(context, listen: false)
            .getOneMuseumHallById(museumHallId);
        _initValues = {
          'name': _editedMuseumHall.name,
          'order': _editedMuseumHall.order,
          'categoryId': _editedMuseumHall.categoryId,
          'description': _editedMuseumHall.description,
        };
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    final museumsHallsProv = Provider.of<MuseumsHalls>(context, listen: false);

    if (_editedMuseumHall.id != null) {
      museumsHallsProv.updateMuseumHall(_editedMuseumHall, context);
    } else {
      museumsHallsProv.addNewMuseumHall(_editedMuseumHall);
    }
    Navigator.of(context).pushReplacementNamed(MuseumNavSuppScreen.routeName,
        arguments: _editedMuseumHall.museumId);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    Map<String, String> categoryMap = {};
    Provider.of<Categories>(context)
        .items
        .forEach((category) => categoryMap[category.id] = category.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit work time'),
        backgroundColor: color.primaryColor,
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropDownField(
                value: _initValues['categoryId'] != ''
                    ? categoryMap[_initValues['categoryId']].toString()
                    : null,
                textStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                labelStyle: TextStyle(fontSize: 16, color: color.primaryColor),
                labelText: 'Category',
                required: true,
                enabled: true,
                items: categoryMap.values.toList(),
                setter: (value) {
                  _editedMuseumHall = MuseumHalls(
                    id: _editedMuseumHall.id,
                    name: _editedMuseumHall.name,
                    order: _editedMuseumHall.order,
                    museumId: _editedMuseumHall.museumId,
                    categoryId: categoryMap.keys
                        .firstWhere((key) => categoryMap[key] == value),
                    description: _editedMuseumHall.description,
                  );
                },
                onValueChanged: (value) {
                  setState(() {
                    category = categoryMap.keys
                        .firstWhere((key) => categoryMap[key] == value);
                  });
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration:
                    const InputDecoration(labelText: 'Enter a description'),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedMuseumHall = MuseumHalls(
                    id: _editedMuseumHall.id,
                    name: _editedMuseumHall.name,
                    order: _editedMuseumHall.order,
                    museumId: _editedMuseumHall.museumId,
                    categoryId: _editedMuseumHall.categoryId,
                    description: value,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['name'],
                decoration: const InputDecoration(
                    labelText: 'Enter the name of the hall'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_orderFocusNode);
                },
                onSaved: (value) {
                  _editedMuseumHall = MuseumHalls(
                    id: _editedMuseumHall.id,
                    name: value,
                    order: _editedMuseumHall.order,
                    museumId: _editedMuseumHall.museumId,
                    categoryId: _editedMuseumHall.categoryId,
                    description: _editedMuseumHall.description,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a valid museum hall name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['order'].toString(),
                decoration: const InputDecoration(
                    labelText: 'Enter the museum hall order'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _orderFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedMuseumHall = MuseumHalls(
                    id: _editedMuseumHall.id,
                    name: _editedMuseumHall.name,
                    order: int.parse(value),
                    museumId: _editedMuseumHall.museumId,
                    categoryId: _editedMuseumHall.categoryId,
                    description: _editedMuseumHall.description,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a valid museum hall order';
                  } else if (int.parse(value) <= 0) {
                    return 'Please provide a museum hall order grater than zero';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
