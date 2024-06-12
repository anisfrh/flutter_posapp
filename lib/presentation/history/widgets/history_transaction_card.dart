// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/int_ext.dart';
import 'package:possapp/presentation/history/models/history_transaction_model.dart';
import 'package:possapp/presentation/orders/models/order_models.dart';


class HistoryTransactionCard extends StatelessWidget {
  final OrderModel data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    Key? key,
    required this.data,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 48.0,
          offset: const Offset(0, 2),
          blurStyle: BlurStyle.outer,
          color: AppColors.black.withOpacity(0.06),
        ),
      ]),
      child: ListTile(
        leading: Assets.icons.payments.svg(),
        title: Text(
         data.paymentMethod,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        subtitle: Text('${data.totalQuantity} item'),
        trailing: Text(
         data.totalPrice.currencyFormatRp,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.green,
          ),
        ),
      ),
    );
  }
}
