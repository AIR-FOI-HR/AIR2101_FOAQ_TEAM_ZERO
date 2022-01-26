import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../providers/museums.dart';
import '../../screens/single_musem_configuration/single_museum_configuration_screen.dart';
import '../../widgets/ticket_configuration/elevated_button_settings.dart';

class MuseumTourDuration extends StatefulWidget {
  final String museumId;

  MuseumTourDuration(this.museumId);

  @override
  _MuseumTourDurationState createState() => _MuseumTourDurationState();
}

class _MuseumTourDurationState extends State<MuseumTourDuration> {
  final _formKey = GlobalKey<FormState>();

  var _editedMuseumInformation = Museum(
    id: null,
    name: '',
    address: '',
    description: '',
    imageUrl: '',
    location: '',
    tourDuration: 0,
  );

  var _initValues = {
    'tourDuration': 0,
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
          'tourDuration': _editedMuseumInformation.tourDuration == null
              ? 0
              : _editedMuseumInformation.tourDuration.toInt(),
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
    return LayoutBuilder(builder: (ctx, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: constraints.maxHeight * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tour duration',
              style: color.textTheme.headline5,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  initialValue: _initValues['tourDuration'].toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Museum tour duration (minutes):'),
                  textInputAction: TextInputAction.next,
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
                      tourDuration: double.parse(value),
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a Museum tour duration';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Align(
              alignment: Alignment.center,
              child: ElevatedButtonSetings('Save', _saveForm),
            ),
          ],
        ),
      );
    });
  }
}
