import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';  //Transaction({ this.id, this.title, this.amount, this.date }); constructor

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _userTransaction = [
    Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
    Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(  // Transaction() constructor
      id : DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now()
    );

    setState(() {
      // because _userTransaction is final, this is the way to add the value
      _userTransaction.add(newTx); 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          NewTransaction(_addNewTransaction),

          TransactionList(_userTransaction) //from transaction_list.dart
      ],
    );
  }
}