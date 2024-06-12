// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/build_context_ext.dart';

class PaymentQrisDialog extends StatefulWidget {
  final int price;
  const PaymentQrisDialog({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.highlight_off),
                  color: AppColors.white,
                ),
                const Text(
                  'Pembayaran Qris',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Quicksand',
                    height: 0,
                  ),
                ),
                SizedBox(width: 40), // Spacer for better alignment
              ],
            ),
          ),
          const SpaceHeight(6),
          Container(
            width: context.deviceWidth,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.white,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //   width: 256,
                //   height: 256,
                //   child: Image.asset(name),
                // ),
                SpaceHeight(5),
                Text(
                  'Scan Qris untuk melakukan pembayaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
