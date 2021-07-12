import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions);
  
  List<Map<String , dynamic>> get groupedTransactionValues{
    final DateTime today = DateTime.now();
    return List.generate(7, (index){
      var wekday = today.subtract(Duration(days: index));
      double totalSum = 0.0;

      for(int i = 0; i < recentTransactions.length; i++){
        if(recentTransactions[i].date?.day == wekday.day &&
        recentTransactions[i].date?.month == wekday.month &&
        recentTransactions[i].date?.year == wekday.year){
          totalSum += recentTransactions[i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(wekday).substring(0,1),
        'amount':totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0, (previousValue, element){
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((thisone) {
            return Expanded(
              child: ChartBar(
                  label: thisone['day'],
                  spendingAmount: thisone['amount'],
                  spendingPctOfTotal:totalSpending == 0.0 ? 0.0 : thisone['amount'] / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
