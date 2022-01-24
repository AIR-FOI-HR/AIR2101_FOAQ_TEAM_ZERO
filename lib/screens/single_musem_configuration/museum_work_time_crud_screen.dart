import 'package:flutter/material.dart';
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
  final _workTimeTo = FocusNode();
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
    _workTimeTo.dispose();
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

    Provider.of<WorkTimes>(context, listen: false)
        .updateWorkTime(_editedWorkTime);

    Navigator.of(context).pop();
  }

  TimeOfDay convertStringToTime(String time) {
    var splittedTime = time.split(':');
    return TimeOfDay(
        hour: int.parse(splittedTime[0]), minute: int.parse(splittedTime[1]));
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                decoration: const InputDecoration(labelText: 'Openig hour:'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_workTimeTo);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
