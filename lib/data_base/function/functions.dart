import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_manager/data_base/model/moneymodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<MoneyModel>> transactionlist = ValueNotifier([]);

class DatabaseHelper {
  static late Database db;

  static Future<void> initDatabase() async {
    final String path = join(await getDatabasesPath(), "moneydatabase.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE   IF NOT EXISTS moneymodel(id INTEGER PRIMARY KEY,sourse TEXT,category TEXT,amount TEXT)''');
      },
    );
  }

  static Future<List<MoneyModel>> getAllData() async {
    final List<Map<String, dynamic>> transactionlist =
        await db.query("moneymodel");
    return
       transactionlist .map((element) => MoneyModel.fromMap(element))
        .toList();
  }

  static Future<int?> insertTransaction(MoneyModel transaction) async {
    return db.rawInsert(
        'INSERT INTO moneymodel(sourse,category,amount)VALUES(?,?,?)',
        [transaction.source, transaction.category, transaction.amount]);

  }
}
