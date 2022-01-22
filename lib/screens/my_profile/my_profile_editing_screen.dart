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
            onPressed: _saveForm,
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
                    userRole: _editedUser.userRole,
                    salt: _editedUser.salt,
                    userImage: _editedUser.userImage,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['surname'],
                decoration: const InputDecoration(labelText: 'Surname:'),
                textInputAction: TextInputAction.next,
                focusNode: _surnameFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_usernameFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    surname: value,
                    username: _editedUser.username,
                    email: _editedUser.email,
                    password: _editedUser.password,
                    userRole: _editedUser.userRole,
                    salt: _editedUser.salt,
                    userImage: _editedUser.userImage,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a surname';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['username'],
                decoration: const InputDecoration(labelText: 'Username:'),
                textInputAction: TextInputAction.next,
                focusNode: _usernameFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    surname: _editedUser.surname,
                    username: value,
                    email: _editedUser.email,
                    password: _editedUser.password,
                    userRole: _editedUser.userRole,
                    salt: _editedUser.salt,
                    userImage: _editedUser.userImage,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['email'],
                decoration: const InputDecoration(labelText: 'E-mail:'),
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    surname: _editedUser.surname,
                    username: _editedUser.username,
                    email: value,
                    password: _editedUser.password,
                    userRole: _editedUser.userRole,
                    salt: _editedUser.salt,
                    userImage: _editedUser.userImage,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a email';
                  }
                  if (userDataProvider.isValidEmail(value)) {
                    return 'Please provide a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['phone'],
                decoration: const InputDecoration(labelText: 'Phone:'),
                textInputAction: TextInputAction.next,
                focusNode: _phoneFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaved: (value) {
                  _editedUser = User(
                    id: _editedUser.id,
                    name: _editedUser.name,
                    surname: _editedUser.surname,
                    username: _editedUser.username,
                    email: _editedUser.email,
                    phoneNumber: value,
                    password: _editedUser.password,
                    userRole: _editedUser.userRole,
                    salt: _editedUser.salt,
                    userImage: _editedUser.userImage,
                  );
                },
                validator: (value) {
                  if (value.isNotEmpty) {
                    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                    RegExp regExp = RegExp(pattern);
                    if (!regExp.hasMatch(value)) {
                      return 'Please provide a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'New password:'),
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocusNode,
                obscureText: true,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                onSaved: (value) {
                  if (value.isEmpty) {
                    _editedUser = User(
                      id: _editedUser.id,
                      name: _editedUser.name,
                      surname: _editedUser.surname,
                      username: _editedUser.username,
                      email: _editedUser.email,
                      phoneNumber: _editedUser.phoneNumber,
                      password: _editedUser.password,
                      userRole: _editedUser.userRole,
                      salt: _editedUser.salt,
                      userImage: _editedUser.userImage,
                    );
                  } else {
                    _editedUser = User(
                      id: _editedUser.id,
                      name: _editedUser.name,
                      surname: _editedUser.surname,
                      username: _editedUser.username,
                      email: _editedUser.email,
                      phoneNumber: _editedUser.phoneNumber,
                      password:
                          userDataProvider.useHash(value + _editedUser.salt),
                      userRole: _editedUser.userRole,
                      salt: _editedUser.salt,
                      userImage: _editedUser.userImage,
                    );
                  }
                },
                validator: (value) {
                  if (value.isNotEmpty) {
                    if (value.length <= 5) {
                      return 'Please enter a password length greater than 5 characters';
                    }
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.contain,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          if (value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL';
                          }
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedUser = User(
                          id: _editedUser.id,
                          name: _editedUser.name,
                          surname: _editedUser.surname,
                          username: _editedUser.username,
                          email: _editedUser.email,
                          phoneNumber: _editedUser.phoneNumber,
                          password: _editedUser.password,
                          userRole: _editedUser.userRole,
                          salt: _editedUser.salt,
                          userImage: value.isEmpty ? null : value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
