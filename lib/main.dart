import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keke',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      date: DateTime.now(),
      item: "Clear Button (Check)",
      price: 18.89,
      id: '1'),

    Transaction(
      date: DateTime.now(),
      item: "Disable Clear btn(Check)",
      price: 18.89,
      id: '2'),
    
    Transaction(
      date: DateTime.now(),
      item: "No Tx MSG (Check)",
      price: 18.89,
      id: '3'),

    Transaction(
      date: DateTime.now(),
      item: "Multiplier for mul items ????",
      price: 18.89,
      id: '4'),
  ];


  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      var sevenFromToday = DateTime.now().subtract(Duration(days: 7));
      return tx.date.isAfter(sevenFromToday);
    }).toList();
  }


  void _addNewTransaction(String itemTx, double priceTx, DateTime date){
    final newTx = Transaction(
      id: (_userTransactions.length+1).toString(),
      date: date,
      item: itemTx,
      price: priceTx
    );
    
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
        return  GestureDetector( 
          onTap: () {},
          child: NewTransaction(_addNewTransaction, _clearAllTransactions, _userTransactions),
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  void _clearAllTransactions(){
      setState(() {
        _userTransactions.removeRange(0, _userTransactions.length);
      });
  }

  void _deleteATransaction(int index){
    setState(() {
      _userTransactions.removeAt(index);
    });
  }
  @override
  Widget build( BuildContext build){
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
        actions: <Widget>[
          IconButton(icon: Icon(
            Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
            <Widget>[
            Chart(_recentTransactions),
            //Text(_recentTransactions.toString()),
            TransactionList(_userTransactions, _deleteATransaction),
          ],
    ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}