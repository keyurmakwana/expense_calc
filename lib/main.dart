import 'package:expense_calc3/model/transaction.dart';
import 'package:expense_calc3/widgets/chart.dart';
import 'package:expense_calc3/widgets/new_transaction.dart';
import 'package:expense_calc3/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    //   Transaction(
    //       amount: 72.5, date: DateTime.now(), id: 't1', title: 'New shoes'),
    //   Transaction(
    //       amount: 122.5, date: DateTime.now(), id: 't2', title: 'New pant'),
    //   Transaction(
    //       amount: 122.5, date: DateTime.now(), id: 't3', title: 'New pant'),
    //   Transaction(
    //       amount: 122.5, date: DateTime.now(), id: 't4', title: 'New pant'),
  ];

  void _addNewTransaction(String titleTx, double amountTx, DateTime dateTx) {
    final newTx = Transaction(
        amount: amountTx,
        date: dateTx,
        id: DateTime.now().toString(),
        title: titleTx);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _deleteTransaction(String idTx) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == idTx);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBard = AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
            onPressed: () => startNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    final chartW1 = Container(
        height: (MediaQuery.of(context).size.height -
                appBard.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransaction));

    final listQ = Container(
        height: (MediaQuery.of(context).size.height -
                appBard.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBard,
      body: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
          if (!isLandscape) chartW1,
          if (!isLandscape) listQ,
          if (isLandscape)
            (_showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBard.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransaction))
                : listQ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => startNewTransaction(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
