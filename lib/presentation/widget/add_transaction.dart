import 'package:flutter/material.dart';
import 'package:money_manager/data_base/model/moneymodel.dart';
import 'package:money_manager/enum/save_edit_model.dart';

import 'package:money_manager/provider/money_controller.dart';

import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({
    super.key,
    required sourceController,
    required categoryController,
    required amountController,
    required selectedcategory,
  });

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late final TextEditingController sourceController;
  late final TextEditingController categoryController;
  late final TextEditingController amountController;
  late final FocusNode sourseFocusnode;
  late final FocusNode categoryFocusnode;
  late final FocusNode amountFocusnode;
  late final ValueNotifier<String?> selectedcategorynotifier;

  SaveEditModel saveEditModel = SaveEditModel.save;

  @override
  void initState() {
    sourceController = TextEditingController();
    categoryController = TextEditingController();
    amountController = TextEditingController();
    sourseFocusnode = FocusNode();
    categoryFocusnode = FocusNode();
    amountFocusnode = FocusNode();
    saveEditModel = saveEditModel;
    selectedcategorynotifier = ValueNotifier<String?>(null);
    super.initState();
  }

  void unFocusAllFocusNode() {
    sourseFocusnode.unfocus();
    categoryFocusnode.unfocus();
    amountFocusnode.unfocus();
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }

  String? selectedcategory;
  List<String> categoryItems = ["INCOME", "EXPENSE"];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Column(
        children: [
          TextFormField(
            controller: sourceController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text("Source"),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ValueListenableBuilder(
            valueListenable: selectedcategorynotifier,
            builder: (BuildContext context, selectedcategory, Widget? child) {
              return DropdownButtonFormField(
                  value: selectedcategory,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("category"),
                      hintText: "select category"),
                  items: categoryItems.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      selectedcategorynotifier.value = newValue;
                      categoryController.text = newValue;
                    }
                  });
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: amountController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Amount",
              hintText: "Enter the amount",
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (saveEditModel == SaveEditModel.save) {
                  final moneyToSave = MoneyModel(
                      source: sourceController.text.trim(),
                      category: categoryController.text.trim(),
                      amount: int.parse(amountController.text.trim()));
                  await context
                      .read<MoneyController>()
                      .insertMoneytransaction(moneyToSave);
                  sourceController.clear();
                  categoryController.clear();
                  amountController.clear();
                  unFocusAllFocusNode();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: saveEditModel == SaveEditModel.save
                    ? Colors.green
                    : Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                  saveEditModel == SaveEditModel.save ? "Update" : "Save")),
        ],
      ),
    );
  }
}
