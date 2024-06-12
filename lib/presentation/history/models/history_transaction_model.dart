// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:possapp/core/extensions/int_ext.dart';

class HistoryTransactionModel {
  final String name;
  final String category;
  final int price;

  HistoryTransactionModel({
    required this.name,
    required this.category,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
