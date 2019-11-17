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
      height: 450,  // to make it fix on the screen // ListView needs height and Container!
      child: transactions.isEmpty 
        ? Column(
            children: <Widget>[
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 20,),  //SizedBox = separator
            Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))  // BoxFit reflect to height:200
            ],
          ) 
        : ListView.builder(  //was Column()  // ListView = Column + SingleChildScrollView
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            // we dont need .map.toList() anymore because itemBuilder and itemCount
            return Card(
              child: Row(
                children: <Widget>[
                  // Price widget
                  Container(
                    margin: EdgeInsets.symmetric( vertical: 20, horizontal: 15 ),
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',  
                      // $ 69.99999 -> $ 70.00 (fixed 2 fraction digits) 
                      // $ should be backslashed to can be shown
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColorDark
                      ), ),
                    decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColorDark, width: 2, )),
                    padding: EdgeInsets.all(10),
                  ),
                  
                  // Title and date widget
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // make content to the left
                    children: <Widget>[
                      Text(transactions[index].title, style: Theme.of(context).textTheme.title,),
                      Text( DateFormat.yMMMd().format(transactions[index].date), style: TextStyle( color: Theme.of(context).primaryColorDark ), ),
                  ],)
                ],
              ),
            );  //end of return with semicolon
          },  // itemBuilder is REQUIRED in ListView.builder
        ),
    );
  }
}