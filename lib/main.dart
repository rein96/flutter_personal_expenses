import 'package:flutter/material.dart';

import 'package:expenses/widgets/user_transactions.dart';
import './models/transaction.dart';
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

class MyHomePage extends StatelessWidget {
  // <Transaction> from transaction.dart
  // final List<Transaction> transactions = [
  // ...
  // ];

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
      body: SingleChildScrollView(  // To implement scrolling functionality
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
            UserTransactions()  // a Column()

          ],
        ),
      )
    );
  }
}
