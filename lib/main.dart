import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // for SystemChrome

import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:expenses/widgets/new_transaction.dart';
import './models/transaction.dart';
// import 'package:expenses/widgets/user_transactions.dart';
// import 'package:expenses/widgets/transaction_list.dart';
// import 'package:expenses/widgets/new_transaction.dart';

void main() {
  // To setting the phone only available at portrait (up and down)
  // when the phone is rotated, it is still the portrait mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);

  runApp(MyApp());
}

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
          button: TextStyle(
            color: Colors.white
          )
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

  bool _isShowChart = false;
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

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(  // Transaction() constructor
      id : DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate
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

  void _deleteTransactions(id) {
    setState(() {
      _userTransactions.removeWhere((el) {
        return el.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBarObj = AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),  // from BuildContext context
          )
        ],
    );

    final chartWidget = Container(
                  // MediaQuery.of(context).size.height = size of the phone ?
                  // appBarObj.preferredSize.height = size of the appBar
                  // MediaQuery.of(context).padding.top = size of the status bar
                  height: ( MediaQuery.of(context).size.height - appBarObj.preferredSize.height - MediaQuery.of(context).padding.top ) *  (isLandScape ? 0.7 : 0.3), // was 0.3
                  child: Chart(_recentTransactions)
                );

    final transactionListWidget = Container(
                  height: ( MediaQuery.of(context).size.height - appBarObj.preferredSize.height - MediaQuery.of(context).padding.top ) * 0.7,
                  child: TransactionList(_userTransactions, _deleteTransactions)
                );

    print('appBarObj.preferredSize.height = ${appBarObj.preferredSize.height}');

    return Scaffold(
      appBar: appBarObj,
      body: SingleChildScrollView(  // When the phone is roated, the screen can be scrolled correctly
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              // Landscape = Show switch Chart
              if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(value: _isShowChart, onChanged: (val) {
                    setState(() {
                      _isShowChart = val;
                    });
                  },)
                ],
              ),

              // Portrait mode = show chart + transactionlist
              if (isLandScape == false) chartWidget,
              if (isLandScape == false) transactionListWidget,

              // Landscape = chart or transactionList based on Show Chart switch boolean
              if (isLandScape)
              _isShowChart 
              ? chartWidget
              : transactionListWidget
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
