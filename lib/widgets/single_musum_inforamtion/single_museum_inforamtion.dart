import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum.dart';
import '../../providers/museums.dart';

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

  @override
  void dispose() {
    _museumAddress.dispose();
    _museumDescription.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'address': '',
    'description': '',
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final museumId = ModalRoute.of(context).settings.arguments as String;
      if (museumId != null) {
        _editedMuseumInformation =
            Provider.of<Museums>(context, listen: false).getById(museumId);
        _initValues = {
          'name': _editedMuseumInformation.name,
          'address': _editedMuseumInformation.address,
          'description': _editedMuseumInformation.description,
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
    Provider.of<Museums>(context).updateMuseum(_editedMuseumInformation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        children: [
          Text(
            'Museum information',
            style: color.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
