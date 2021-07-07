import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onPressed;
  NewTransaction(this.onPressed);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTransaction() {
    final String txtTitle = _titleController.text;
    final double txtAmount = double.parse(_amountController.text);
    if (txtTitle.isEmpty || txtAmount <= 0 || _selectedDate == null) return;
    widget.onPressed(txtTitle, txtAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => _submitTransaction,
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitTransaction,
          ),
          Container(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitTransaction,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
