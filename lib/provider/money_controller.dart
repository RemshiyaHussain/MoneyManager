import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_manager/data_base/function/functions.dart';
import 'package:money_manager/data_base/model/moneymodel.dart';

class MoneyController with ChangeNotifier {
  MoneyController() {
    getAllMoneytransaction();
  }
  List<MoneyModel> moneycontrollerItems = [];
  UnmodifiableListView<MoneyModel> get transactionlist =>
      UnmodifiableListView(moneycontrollerItems);

  Future<void> insertMoneytransaction(MoneyModel money) async {
  await DatabaseHelper.insertTransaction(money);
  moneycontrollerItems = await DatabaseHelper.getAllData();
  notifyListeners();  // This ensures UI updates when a new transaction is added
}


  Future<void> getAllMoneytransaction() async {
    moneycontrollerItems = await DatabaseHelper.getAllData();
    log(moneycontrollerItems.toString(),
        name: "get all money treansactions here");
        notifyListeners();
  }
}
