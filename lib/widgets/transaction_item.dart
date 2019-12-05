import 'dart:math'; // Random()

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  // state
  Color _backgroundColor;

  @override
  void initState() {
    const availableColors=[Colors.red, Colors.blue, Colors.purple];  

    // initState() shouldn't use setState() 
    _backgroundColor = availableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}')
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date)
        ),
        trailing: MediaQuery.of(context).size.width > 460 
          ? FlatButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              textColor: Theme.of(context).errorColor,
              onPressed: () => widget.deleteTransaction(widget.transaction.id),
            )
          : 
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,  //default is red
              onPressed: () => {widget.deleteTransaction(widget.transaction.id)},
            ),
      ),
    );
  }
}