import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../providers/museums.dart';
import '../../widgets/ticket_configuration/elevated_button_settings.dart';
import '../../screens/single_musem_configuration/single_museum_configuration_screen.dart';

class SingleMuseumInformation extends StatefulWidget {
  final museumId;

  SingleMuseumInformation(this.museumId);

  @override
  _SingleMuseumInformationState createState() =>
      _SingleMuseumInformationState();
}

class _SingleMuseumInformationState extends State<SingleMuseumInformation> {
  final _museumAddress = FocusNode();
  final _museumDescription = FocusNode();
  final _museumImageUrl = FocusNode();
  final _museumCapacity = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _editedMuseumInformation = Museum(
    id: null,
    name: '',
    address: '',
    description: '',
    imageUrl: '',
    location: '',
    tourDuration: 0,
    capacity: 0,
  );

  @override
  void dispose() {
    _museumAddress.dispose();
    _museumDescription.dispose();
    _museumImageUrl.dispose();
    _museumCapacity.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'address': '',
    'description': '',
    'capacity': 0,
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final museumId = widget.museumId;
      if (museumId != null) {
        _editedMuseumInformation =
            Provider.of<Museums>(context, listen: false).getById(museumId);
        _initValues = {
          'name': _editedMuseumInformation.name,
          'address': _editedMuseumInformation.address,
          'description': _editedMuseumInformation.description,
          'capacity': _editedMuseumInformation.capacity,
          'imageUrl': _editedMuseumInformation.imageUrl ?? '',
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
    Provider.of<Museums>(context, listen: false)
        .updateMuseum(_editedMuseumInformation);
    Navigator.of(context)
        .pushReplacementNamed(SingleMuseumConfigurationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: constraints.maxHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Museum information',
                style: color.textTheme.headline5,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: constraints.maxHeight * 0.75,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['name'],
                        decoration:
                            const InputDecoration(labelText: 'Museum name:'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_museumAddress);
                        },
                        onSaved: (value) {
                          _editedMuseumInformation = Museum(
                            id: _editedMuseumInformation.id,
                            name: value,
                            address: _editedMuseumInformation.address,
                            description: _editedMuseumInformation.description,
                            imageUrl: _editedMuseumInformation.imageUrl,
                            location: _editedMuseumInformation.location,
                            tourDuration: _editedMuseumInformation.tourDuration,
                            capacity: _editedMuseumInformation.capacity,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a Museum name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['address'],
                        decoration:
                            const InputDecoration(labelText: 'Museum address:'),
                        textInputAction: TextInputAction.next,
                        focusNode: _museumAddress,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_museumDescription);
                        },
                        onSaved: (value) {
                          _editedMuseumInformation = Museum(
                            id: _editedMuseumInformation.id,
                            name: _editedMuseumInformation.name,
                            address: value,
                            description: _editedMuseumInformation.description,
                            imageUrl: _editedMuseumInformation.imageUrl,
                            location: _editedMuseumInformation.location,
                            tourDuration: _editedMuseumInformation.tourDuration,
                            capacity: _editedMuseumInformation.capacity,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a Museum name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: const InputDecoration(
                            labelText: 'Museum description:'),
                        textInputAction: TextInputAction.next,
                        focusNode: _museumDescription,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          _editedMuseumInformation = Museum(
                            id: _editedMuseumInformation.id,
                            name: _editedMuseumInformation.name,
                            address: _editedMuseumInformation.address,
                            description: value,
                            imageUrl: _editedMuseumInformation.imageUrl,
                            location: _editedMuseumInformation.location,
                            tourDuration: _editedMuseumInformation.tourDuration,
                            capacity: _editedMuseumInformation.capacity,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a Museum description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['imageUrl'],
                        decoration: const InputDecoration(
                            labelText: 'Museum imageUrl:'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_museumCapacity);
                        },
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          _editedMuseumInformation = Museum(
                            id: _editedMuseumInformation.id,
                            name: _editedMuseumInformation.name,
                            address: _editedMuseumInformation.address,
                            description: _editedMuseumInformation.description,
                            imageUrl: value,
                            location: _editedMuseumInformation.location,
                            tourDuration: _editedMuseumInformation.tourDuration,
                            capacity: _editedMuseumInformation.capacity,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['capacity'].toString(),
                        decoration: const InputDecoration(
                            labelText: 'Museum capacity:'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _museumCapacity,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedMuseumInformation = Museum(
                            id: _editedMuseumInformation.id,
                            name: _editedMuseumInformation.name,
                            address: _editedMuseumInformation.address,
                            description: _editedMuseumInformation.description,
                            imageUrl: _editedMuseumInformation.imageUrl,
                            location: _editedMuseumInformation.location,
                            tourDuration: _editedMuseumInformation.tourDuration,
                            capacity: int.parse(value),
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a Museum capacity';
                          }
                          if (int.parse(value) <= 0) {
                            return 'Please provide a Museum capacity greater than 0';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButtonSetings('Save', _saveForm)),
            ],
          ),
        );
      },
    );
  }
}
