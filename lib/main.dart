import 'package:flutter/material.dart';

import 'package:expenses/widgets/chart.dart';
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
      title: 'Personal Expenses!',
      theme: ThemeData(
        // primarySwatch = generates different shades of the color (lighter or darker)
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(  // global theme
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        appBarTheme: AppBarTheme( 
          textTheme: ThemeData.light().textTheme.copyWith(  // only qworks at AppBar
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
        ))
      ),
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

  final List<Transaction> _userTransactions = [
    // Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
    // Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where( (tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(  // Transaction() constructor
      id : DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now()
    );

    setState(() {
      // because _userTransactions is final, this is the way to add the value
      _userTransactions.add(newTx); 
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
        title: Text('Personal Expenses'),
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
              Chart(_recentTransactions),
              TransactionList(_userTransactions)
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
