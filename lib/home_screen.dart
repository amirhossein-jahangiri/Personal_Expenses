import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';
import 'model/transaction.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = <Transaction>[
    // Transaction(
    //   id: '1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    //Transaction(
    //   id: '2',
    //   title: 'Weekly Groceries',
    //   amount: 39.59,
    //   date: DateTime.now(),
    // ),
  ];

  bool _isActiveChart = false;

  void _addNewTransaction(
      String txtTitle, double txtAmount, DateTime chosenDate) {
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: txtTitle,
      amount: txtAmount,
      date: chosenDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    setState(() {});
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
        //return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((thisone) => thisone.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((thisone) {
      final DateTime today = DateTime.now();
      final late = today.subtract(Duration(days: 7));
      return thisone.date!.isAfter(late);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    final bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _isActiveChart,
                    onChanged: (value) {
                      setState(() {
                        _isActiveChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!_isLandscape)
              Container(
                height: size.height * 0.27,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape)
              Container(
                height: size.height * 0.6,
                child: TransactionList(_transactions, _deleteTransaction),
              ),
            if (_isLandscape)
              _isActiveChart
                  ? Container(
                      height: size.height * 0.5,
                      child: Chart(_recentTransactions),
                    )
                  : Container(
                      height: size.height * 0.6,
                      child: TransactionList(_transactions, _deleteTransaction),
                    ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
