import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double daySpending;
  final double weekSpendingPctOfTotal;

  ChartBar(this.day, this.daySpending, this.weekSpendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight * .1,
          child: FittedBox(
            child: Text(
              '\$${daySpending.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * .05),
        Container(
          height: constraints.maxHeight * .6,
          width: 12,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[350],
                ),
              ),
              FractionallySizedBox(
                heightFactor: weekSpendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: constraints.maxHeight * .05),
        Container(
          height: constraints.maxHeight * .1,
          child: FittedBox(child: Text('$day'))),
      ],
    );
    });
  }
}