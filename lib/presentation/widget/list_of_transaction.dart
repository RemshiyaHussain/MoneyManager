import 'package:flutter/material.dart';
import 'package:money_manager/data_base/function/functions.dart';
import 'package:money_manager/data_base/model/moneymodel.dart';
import 'package:money_manager/provider/money_controller.dart';
import 'package:provider/provider.dart';

class ListOfTransaction extends StatelessWidget {
  const ListOfTransaction({super.key});

  // final void Function(MoneyModel transactionlist, int index) callback;
  // const ListOfTransaction({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyController>(
      builder:
          (BuildContext context, MoneyController moneycontroller, Widget? _) {
        return Expanded(
            child: ListView.separated(
          itemBuilder: (context, index) {
            final data = moneycontroller.moneycontrollerItems[index];

            return Card(
              child: ListTile(
                title: Text(data.source),
                subtitle: Row(
                  children: [Text(data.category), Text(data.amount.toString())],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(children: [
                    IconButton(
                        onPressed: () async {
                          // await deleteStudent(data.id!);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {
                          // callback(data, index);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        )),
                  ]),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: moneycontroller.moneycontrollerItems.length,
        ));
      },
    );
  }
}
