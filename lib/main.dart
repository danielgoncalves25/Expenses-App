import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // Disable Landscap mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(primarySwatch: Colors.orange),
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
  bool _showChart = false;
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      var sevenFromToday = DateTime.now().subtract(Duration(days: 7));
      return tx.date.isAfter(sevenFromToday);
    }).toList();
  }

  void _addNewTransaction(String itemTx, double priceTx, DateTime date) {
    final newTx = Transaction(
        id: (_userTransactions.length + 1).toString(),
        date: date,
        item: itemTx,
        price: priceTx);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(
                _addNewTransaction, _clearAllTransactions, _userTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _clearAllTransactions() {
    setState(() {
      _userTransactions.removeRange(0, _userTransactions.length);
    });
  }

  void _deleteATransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext build) {
    final appBar = AppBar(
      title: Text("Expense App"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final double heighting = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() => _showChart = val);
                  },
                )
              ],
            ),
            _showChart
                ? Container(
                    height: heighting * .2, child: Chart(_recentTransactions))
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: heighting * 0.02),
              child: Container(
                  height: heighting * (_showChart ? .68 : .88),
                  child:
                      TransactionList(_userTransactions, _deleteATransaction)
              ),
            ),
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
