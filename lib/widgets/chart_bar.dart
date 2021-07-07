import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spendingAmount;
  final double? spendingPctOfTotal;

  const ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPctOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    print('chart bar - total spending is ${spendingPctOfTotal}');
    return Column(
      children: [
        Container(
          height: 20.0,
          child: FittedBox(
            child: Text('\$${spendingAmount!.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label!),
      ],
    );
  }
}
