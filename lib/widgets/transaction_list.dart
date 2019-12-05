import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // DateFormat().format

import 'package:expenses/models/transaction.dart';  //Transaction
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction); //constructor

  // final List<Transaction> _userTransaction = [
  //   Transaction( id : 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now() ),
  //   Transaction( id : 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now() ),
  // ];

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty 
        // BIG ZZZ PICTURE
        ? LayoutBuilder(builder: (ctx, constraints) {
          // constraints from Container height MediaQuery
          return Column(
            children: <Widget>[
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 20,),  //SizedBox = separator
            Container(
              height: constraints.maxHeight * 0.7,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))  // BoxFit reflect to height:200
            ],
          ); 
        },)

        // If there is transaction(s)
        : ListView(
            children: transactions.map( (tx) => TransactionItem( key: ValueKey(tx.id), transaction: tx, deleteTransaction: deleteTransaction,) ).toList(),
          );
        
        // ListView.builder is not used in order to give 'Key' in TransactionItem
        // ListView.builder(  //was Column()  // ListView = Column + SingleChildScrollView
        //   itemCount: transactions.length,
        //   itemBuilder: (context, index) {
        //     return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
  }
}