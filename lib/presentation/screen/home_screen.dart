import 'package:flutter/material.dart';
import 'package:money_manager/data_base/function/functions.dart';
import 'package:money_manager/data_base/model/moneymodel.dart';

import 'package:money_manager/presentation/widget/add_transaction.dart';
import 'package:money_manager/presentation/widget/list_of_transaction.dart';
import 'package:money_manager/provider/money_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController sourceController;
  late final TextEditingController categoryController;
  late final TextEditingController amountController;
  ValueNotifier<String?> selectedcategory = ValueNotifier<String?>(null);
  @override
  void initState() {
    sourceController = TextEditingController();
    categoryController = TextEditingController();
    amountController = TextEditingController();
    context.read<MoneyController>().getAllMoneytransaction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Money Manager",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AddTransaction(
              sourceController: sourceController,
              categoryController: categoryController,
              amountController: amountController,
              selectedcategory: selectedcategory,
            ),
            ListOfTransaction()
          ],
        ),
      ),
    );
  }
}
