import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/users.dart';

class MyProfileEditingScreen extends StatefulWidget {
  static const routeName = '/myProfileEditing';

  @override
  State<MyProfileEditingScreen> createState() => _MyProfileEditingScreenState();
}

class _MyProfileEditingScreenState extends State<MyProfileEditingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _surnameFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var _editedUser = User(
    id: null,
    name: '',
    surname: '',
    username: '',
    email: '',
    password: '',
    salt: '',
    userRole: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'surname': '',
    'username': '',
    'phone': '',
    'email': '',
    'password': '',
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final username = ModalRoute.of(context).settings.arguments as String;
      if (username != null) {
        _editedUser =
            Provider.of<Users>(context, listen: false).findByUsername(username);
        _initValues = {
          'name': _editedUser.name,
          'surname': _editedUser.surname,
          'username': _editedUser.username,
          'phone': _editedUser.phoneNumber,
          'email': _editedUser.email,
          'password': _editedUser.password,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedUser.userImage;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedUser.id != null) {
      Provider.of<Users>(context, listen: false)
          .updateUser(_editedUser.id, _editedUser);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final userDataProvider = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: color.primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.save_rounded,
              size: 32,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['name'],
                decoration: const InputDecoration(labelText: 'Name:'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_surnameFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: value,
                    surname: _editedUser.surname,
                    username: _editedUser.username,
                    email: _editedUser.email,
                    password: _editedUser.password,
                    salt: _editedUser.salt,
                    userRole: _editedUser.userRole,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a name';
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
