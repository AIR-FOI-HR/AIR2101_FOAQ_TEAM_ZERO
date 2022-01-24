import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';
import '../../models/ticket.dart';
import '../../providers/tickets.dart';
import '../../widgets/ticket_configuration/elevated_button_settings.dart';

class TicketCrudScreen extends StatefulWidget {
  static const routeName = '/EditTicket';

  @override
  State<TicketCrudScreen> createState() => _TicketCrudScreenState();
}

class _TicketCrudScreenState extends State<TicketCrudScreen> {
  final String loggedUserUsername = 'ttomiek';
  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _editedTicket = Ticket(
    id: null,
    name: '',
    cost: '',
    museumId: '',
  );

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'cost': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final ticketId = ModalRoute.of(context).settings.arguments as String;
      if (ticketId != null) {
        _editedTicket =
            Provider.of<Tickets>(context, listen: false).findById(ticketId);
        _initValues = {
          'name': _editedTicket.name,
          'cost': _editedTicket.cost.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    final ticketProv = Provider.of<Tickets>(context, listen: false);
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedTicket.id != null) {
      ticketProv.updateTicket(_editedTicket);
    } else {
      ticketProv.addNewTicket(_editedTicket);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final museumId =
        Provider.of<Users>(context).findByUsername(loggedUserUsername).museumId;
    final color = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit ticket'),
        backgroundColor: color.primaryColor,
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Please enter a ticket:',
                style: color.textTheme.headline5,
              ),
              TextFormField(
                initialValue: _initValues['name'],
                decoration: const InputDecoration(labelText: 'Ticket name:'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedTicket = Ticket(
                    id: _editedTicket.id,
                    name: value,
                    cost: _editedTicket.cost,
                    museumId: museumId,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a ticket name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['cost'],
                decoration: const InputDecoration(labelText: 'Ticket cost'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedTicket = Ticket(
                    id: _editedTicket.id,
                    name: _editedTicket.name,
                    cost: value,
                    museumId: museumId,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButtonSetings('Cancel', () {
                    Navigator.of(context).pop();
                  }),
                  if (_editedTicket.id != null)
                    ElevatedButtonSetings('Delete', () {
                      Provider.of<Tickets>(context, listen: false)
                          .deleteTicketById(_editedTicket.id);
                      Navigator.of(context).pop();
                    }),
                  ElevatedButtonSetings('Save', _saveForm),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
