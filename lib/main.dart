import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // DateFormat().format

import './models/transaction.dart';

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

class MyHomePage extends StatelessWidget {
  // <Transaction> from transaction.dart
  final List<Transaction> transactions = [
    Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
    Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  ];

  // String titleInput;
  // String amountInput;
  // TextEditingController is an easy way to approach input from user
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
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
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    // onChanged: (val) {
                    //   amountInput = val;
                    // },
                  ),
                  FlatButton(
                    child: Text('Add Transaction'),
                    textColor: Colors.purple,
                    onPressed: () {
                      print(titleController.text);
                      // print(titleInput);
                      // print(amountInput);
                    },
                  )
                ],
              ),
            ), 
          ),
          Column(
            children: transactions.map( (trans) {
              // return should use semicolon
              return Card(
                child: Row(
                  children: <Widget>[
                    // Price widget
                    Container(
                      margin: EdgeInsets.symmetric( vertical: 20, horizontal: 15 ),
                      child: Text(
                        '\$${trans.amount}',  // $ 69.99 // $ should be backslashed to can be shown
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple
                        ), ),
                      decoration: BoxDecoration( border: Border.all(color: Colors.purple, width: 2, )),
                      padding: EdgeInsets.all(10),
                    ),
                    
                    // Title and date widget
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // make content to the left
                      children: <Widget>[
                        Text(trans.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text( DateFormat.yMMMd().format(trans.date), style: TextStyle( color: Colors.grey ), ),
                    ],)
                  ],
                ),
              );  //end of return with semicolon
            }).toList()
          )
        ],
      )
    );
  }
}
