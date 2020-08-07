import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Column(
        children: <Widget>[
          Text(
            "Please add an item",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),
          Container(
            height: 200,
            child: Image.asset(
              "assets/images/waiting.png",
              fit: BoxFit.cover
            ),
          ),
        ],
      );
    }
    return Container(
      height: 550,
      child: ListView.builder(
        itemBuilder: (ctx, index){
          return Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(child: Text('\$${transactions[index].price}')),
                ),
              ),
              title: Text(transactions[index].item),
              subtitle: Text(DateFormat("MM-dd-y").format(transactions[index].date)),
              trailing: Container(
                  child: IconButton(
                    color: Colors.black54,
                    icon: Icon(Icons.delete),
                    onPressed: () {deleteTx(index);},
                  ),
              )
            ),
          );
        },
         itemCount: transactions.length,
        ),
    );
  }
}