import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/screens/single_musem_configuration/single_museum_configuration_screen.dart';
import 'package:provider/provider.dart';

import '../../models/work_time.dart';
import '../../providers/work_times.dart';

class MuseumWorkTimeCrudScreen extends StatefulWidget {
  static const routeName = '/EditMuseumWorkTime';
  @override
  _MuseumWorkTimeCrudScreenState createState() =>
      _MuseumWorkTimeCrudScreenState();
}

class _MuseumWorkTimeCrudScreenState extends State<MuseumWorkTimeCrudScreen> {
  final _closingTime = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _editedWorkTime = WorkTime(
    id: null,
    day: '',
    timeFrom: null,
    timeTo: null,
    museumId: '',
  );

  @override
  void dispose() {
    _closingTime.dispose();
    super.dispose();
  }

  var _initValues = {
    'timeFrom': '',
    'timeTo': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final workTimeId = ModalRoute.of(context).settings.arguments as String;
      _editedWorkTime = Provider.of<WorkTimes>(context, listen: false)
          .findWorkTimeById(workTimeId);
      String startingTime;
      String closingTime;
      if (_editedWorkTime.timeFrom == null) {
        startingTime = '';
      } else {
        var time = _editedWorkTime.timeFrom.format(context).split(' ');
        startingTime = time[0];
      }
      if (_editedWorkTime.timeTo == null) {
        closingTime = '';
      } else {
        var time = _editedWorkTime.timeTo.format(context).split(' ');
        closingTime = time[0];
      }
      _initValues = {
        'timeFrom': startingTime,
        'timeTo': closingTime,
      };
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
    DBCaller.updateWorkTime(_editedWorkTime).then((_) {
      Navigator.of(context)
          .pushReplacementNamed(SingleMuseumConfigurationScreen.routeName);
    });
  }

  TimeOfDay convertStringToTime(String time) {
    var splittedTime = time.split(':');
    return TimeOfDay(
        hour: int.parse(splittedTime[0]), minute: int.parse(splittedTime[1]));
  }

  String timeValidator(String time) {
    var splittedTime = time.split(':');

    int minute = -1;
    int sati = -1;

    if (splittedTime.length == 2) {
      sati = int.tryParse(splittedTime[0]) ?? -1;
      minute = int.tryParse(splittedTime[1]) ?? -1;
    }
    if (sati == -1 && minute == -1) {
      return 'Please provide a valid time, like 8:30';
    }
    if (sati < 0 || minute < 0) {
      return 'Please provide time greater than zero';
    }
    if (sati > 24 || minute > 59) {
      return 'Please provide a valid time, like: 0-24:0-59';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
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
          child: ListView(
            children: [
              Text(
                'Editing day: ${_editedWorkTime.day}',
                style: color.textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: _initValues['timeFrom'],
                decoration: const InputDecoration(
                    labelText: 'Opening hours (format: 8:00 or nothing):'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_closingTime);
                },
                onSaved: (value) {
                  _editedWorkTime = WorkTime(
                    id: _editedWorkTime.id,
                    day: _editedWorkTime.day,
                    timeFrom: value.isEmpty ? null : convertStringToTime(value),
                    timeTo: _editedWorkTime.timeTo,
                    museumId: _editedWorkTime.museumId,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return timeValidator(value);
                },
              ),
              TextFormField(
                initialValue: _initValues['timeTo'],
                decoration: const InputDecoration(
                    labelText: 'Closing hours (format: 8:00 or nothing):'),
                textInputAction: TextInputAction.next,
                focusNode: _closingTime,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedWorkTime = WorkTime(
                    id: _editedWorkTime.id,
                    day: _editedWorkTime.day,
                    timeFrom: _editedWorkTime.timeFrom,
                    timeTo: value.isEmpty ? null : convertStringToTime(value),
                    museumId: _editedWorkTime.museumId,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return timeValidator(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
