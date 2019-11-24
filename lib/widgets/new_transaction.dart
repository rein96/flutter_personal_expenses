import 'dart:io'; // Platform

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() { 
    if( _amountController.text.isEmpty || _titleController.text.isEmpty ){return;}
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);  // convert to text to double 

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null ) {
      return; // prevent error
    }

    widget.addNewTransaction( enteredTitle, enteredAmount, _selectedDate ); 
    // widget came from Refactor to StatefulWidget // only available on Stateful

    Navigator.of(context).pop(); // context from State<> -> context is stored globally in Stateful class
    // To close modalbottomsheet after hit Enter
  }

  void _presentDatePicker() {
    // showDatePicker = Future class = async await or .then
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then( (pickedDate) {
      if (pickedDate == null) {return;}

      setState(() {
        _selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10 // Respecting the SoftKeyboard
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // we can use CupertinoTextField()
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (dummy) => _submitData(), 
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (dummy) => _submitData(), 
                // (dummy) = don't care the argument, because we don't use it but onSubmitted = Function(String)
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Picked Date: ${DateFormat.yMMMMd("en_US").format(_selectedDate)}'
                    ),
                    Expanded(
                      // "Choose Date" button
                      child: AdaptiveFlatButton('Choose Date', _presentDatePicker),
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ), 
      ),
    );
  }
}