import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTx;
  final Function deleteTx;

  TransactionList(this._userTx, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTx.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No Transactions added yet!'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${_userTx[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTx[index].title,
                    style: TextStyle(fontFamily: 'OpenSans'),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_userTx[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.red),
                          ),
                          onPressed: () {
                            deleteTx(_userTx[index].id);
                          })
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTx(_userTx[index].id);
                          },
                        ),
                ),
              );
            },
            itemCount: _userTx.length,
          );
  }
}
