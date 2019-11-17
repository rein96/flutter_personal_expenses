import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() { 
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);  // convert to text to double 

    if(enteredTitle.isEmpty || enteredAmount <= 0 ) {
      return; // prevent error
    }

    widget.addNewTransaction( enteredTitle, enteredAmount ); 
    // widget came from Refactor to StatefulWidget // only available on Stateful

    Navigator.of(context).pop(); // context from State<>
    // To close modalbottomsheet after hit Enter
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (dummy) => submitData(), 
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (dummy) => submitData(), 
              // (dummy) = don't care the argument, because we don't use it but onSubmitted = Function(String)
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ), 
    );
  }
}