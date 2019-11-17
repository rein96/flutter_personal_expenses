import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // DateFormat().format

import 'package:expenses/models/transaction.dart';  //Transaction

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;

  TransactionList(this.transactions); //constructor

  // final List<Transaction> _userTransaction = [
  //   Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
  //   Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,  // to make it fix on the screen
      child: SingleChildScrollView(
          child: Column(
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
          ),
      ),
    );
  }
}