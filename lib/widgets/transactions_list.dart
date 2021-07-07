import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
       height: size.height * 0.6,
      child: transactions.isEmpty
          ? Center(child: Text(
        'Please Add New Transaction',
        style: Theme.of(context).textTheme.headline6,
      ))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
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
                            '\$${transactions[index].amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date!),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
