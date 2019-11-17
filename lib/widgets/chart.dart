import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/models/transaction.dart';  //<Transaction> constructor()


class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions; // sum transactions for the last week

  Chart(this.recentTransactions);

  // getter = property which are calculated dynamically
  List<Map<String, Object>> get groupedTransactionValues {  
    // get = function is called each time when groupedTransactionValues has to be read from another part of the code.
    return List.generate(7,  (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index)); // 2019-11-17 22:14:05.295174
      // print(weekDay); // 2019-11-17 22:14:05.295174 (7 lines on terminal because of 7 index)
      /*
        For each list item the related date is calculated:
        today - 0 = today,
        today - 1 = yesterday,
        ...
        today - 6 = 1 week ago
      */
      var totalSum = 0.0;

      for( var i = 0; i < recentTransactions.length ; i++ ){
        if (recentTransactions[i].date.day == weekDay.day && recentTransactions[i].date.month == weekDay.month && recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      // print(DateFormat.E().format(weekDay));  // Today = Sunday -> Sun | Sat | Fri | Thu | Wed ...
      // print(totalSum);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });  // length = 7, generator = function
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: <Widget>[

      ],),
    );
  }
}