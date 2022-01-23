import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar.dart';
import '../../models/ticket.dart';
import '../../providers/tickets.dart';

class TicketCrudScreen extends StatefulWidget {
  static const routeName = '/EditTicket';

  @override
  State<TicketCrudScreen> createState() => _TicketCrudScreenState();
}

class _TicketCrudScreenState extends State<TicketCrudScreen> {
  final _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _editedTicket = Ticket(
    id: null,
    name: '',
    cost: '',
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
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedTicket.id != null) {
      //ticketPro.updateTicket(_editedTicket);
    } else {
      //ticketPro.addNewTicket(_editedTicket);
    }
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
