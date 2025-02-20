import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoneyModel {
  final int? id;
  final String source;
  final String category;
  final int amount;
  MoneyModel({
    this.id,
    required this.source,
    required this.category,
    required this.amount, });

  factory MoneyModel.fromMap(Map<String, dynamic> map) {
    return MoneyModel(
      id: map["id"] as int,
      source: map["sourse"] as String,
      category: map["category"] as String,
      amount: map["amount"] as int,
    );
  }

  @override
  String toString() {
    return 'MoneyModel(id: $id, source: $source, category: $category, amount: $amount)';
  }
}
