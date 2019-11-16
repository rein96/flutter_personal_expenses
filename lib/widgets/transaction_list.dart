import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _userTransaction = [
    Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
    Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}