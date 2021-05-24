import 'package:expense_calc3/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function deleteTx;

  TransactionList(this._userTransaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _userTransaction.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Container(
                  height: constraints.maxHeight * 1,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.fill,
                  ),
                );
              })
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                              child:
                                  Text('\$${_userTransaction[index].amount}')),
                        ),
                      ),
                      title: Text(
                        _userTransaction[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_userTransaction[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? TextButton.icon(
                              onPressed: () =>
                                  deleteTx(_userTransaction[index].id),
                              icon: Icon(Icons.delete),
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              label: Text('Delete'))
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () =>
                                  deleteTx(_userTransaction[index].id),
                            ),
                    ),
                  );
                },
                itemCount: _userTransaction.length,
              ));
  }
}
