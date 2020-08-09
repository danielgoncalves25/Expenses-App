import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final spendingDate = DateFormat("MM-dd-yyyy").format(weekDay);

      double totalSum = 0;
      //gets the total ammount spend on 1 day
      for (var i = 0; i<transactions.length;i++){
        var day = DateFormat("MM-dd-yyyy").format(transactions[i].date);
        if (day == spendingDate){
          totalSum += transactions[i].price;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0,1), 
        "price": totalSum
      };
    }).reversed.toList();
  }

  double get weeklySpending {
    return groupedTransactions.fold(0.0, (sum,item) {
      return sum + item['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactions);
    return Card(
          elevation: 5,
          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactions.map((tx) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    tx['day'], 
                    tx['price'], 
                    weeklySpending == 0.0 ? 0.0 : (tx['price']as double)/weeklySpending),
                );
              }).toList(),
            ),
          ),
        );
  }
}