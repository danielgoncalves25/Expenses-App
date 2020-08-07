import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {

  final Function newTx;
  final Function clearAllTx;
  final List<Transaction> tx;
  NewTransaction(this.newTx, this.clearAllTx, this.tx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate;
  bool redText;

  void submitData(){
    final String enteredItem = _itemController.text;
    final double enteredPrice = double.parse(_priceController.text);

    if (_selectedDate == null){
      setState(() {
        redText = true;
      });
    }
  
    if (enteredItem.isEmpty || enteredPrice <= 0 || _selectedDate == null){
      return;
    }

    widget.newTx(
      _itemController.text, 
      double.parse(_priceController.text), 
      _selectedDate);
    Navigator.of(context).pop();
    print(redText);
  }

  void _clearData(){
    widget.clearAllTx();
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now()
    ).then((datePicked) {
      if (datePicked == null){
        return;
      }
      setState(() {
        redText = null;
        _selectedDate = datePicked;
      });
    });
  }

  bool _isClearButtonEnabled(){
    return widget.tx.isEmpty ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
         elevation: 5,
         child: Container(
           padding: EdgeInsets.all(10),
           child: Column(
             children: <Widget>[
               TextField(
                decoration: InputDecoration(labelText: "Item"),
                controller: _itemController,
                onSubmitted: (_) => submitData,
                  ),
               TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal:true),
                  onSubmitted: (_) => submitData,
               ),
               Text(
                  _selectedDate == null ? 
                  "Please choose a date" : 
                  DateFormat('MM-dd-y').format(_selectedDate),
                  style: TextStyle(
                    fontWeight: redText == null ? FontWeight.normal : FontWeight.bold,
                    color: redText == null ? Colors.black : Colors.red[600]
                  ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   FlatButton(
                    child: Text("Clear Transations"),
                    textColor: Colors.red[600],
                    // add clearAllTx();
                    onPressed: _isClearButtonEnabled() ? () => {_clearData()} : null, 
                  ),
                   IconButton(icon: Icon(Icons.calendar_today), onPressed: _presentDatePicker),
                   FlatButton(
                     child: Text("Add Transation"),
                     textColor: Theme.of(context).primaryColor,
                     onPressed: () {submitData();},
                    ),
                 ],
               ),
             ],
            ),
         ),
        )
    );
  }
}
