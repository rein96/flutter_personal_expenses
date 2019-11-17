import 'package:flutter/material.dart';

import 'package:expenses/widgets/transaction_list.dart';
import 'package:expenses/widgets/new_transaction.dart';
import './models/transaction.dart';
// import 'package:expenses/widgets/user_transactions.dart';
// import 'package:expenses/widgets/transaction_list.dart';
// import 'package:expenses/widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // <Transaction> from transaction.dart
  // final List<Transaction> transactions = [
  // ...
  // ];

  // String titleInput;
  // String amountInput;
  // TextEditingController is an easy way to approach input from user
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (dummy) {
      return GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),  // from BuildContext context
          )
        ],
      ),
      body: SingleChildScrollView(  // When the phone is roated, the screen can be scrolled correctly
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: Text('CHART!')
                  ),
                  elevation: 10,
                ),
              ),
              TransactionList(_userTransaction)
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),  // from BuildContext context
      ),
    );
  }
}
