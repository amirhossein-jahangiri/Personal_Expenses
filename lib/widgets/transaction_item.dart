import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem(this.transaction , this.deleteTx);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title!,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date!),
        ),
        trailing:mediaQuery.size.width > 550
            ? TextButton.icon(
          onPressed: () =>
              deleteTx(transaction.id),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          label: Text(
            'Delete',
            style:
            TextStyle(color: Theme.of(context).errorColor),
          ),
        )
            : IconButton(
          onPressed: () => deleteTx(transaction.id),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}