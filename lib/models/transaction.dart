import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String item;
  double price;
  DateTime date;

  Transaction({
    @required this.id, 
    @required this.item, 
    @required this.price, 
    @required this.date
    });


}