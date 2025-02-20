import 'package:flutter/material.dart';
import 'package:money_manager/data_base/function/functions.dart';
import 'package:money_manager/presentation/screen/home_screen.dart';
import 'package:money_manager/provider/money_controller.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  runApp(
    ChangeNotifierProvider(
        create: (context) => MoneyController(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
