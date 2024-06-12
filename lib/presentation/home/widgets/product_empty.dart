import 'package:flutter/material.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';

class ProductEmpty extends StatelessWidget {
  const ProductEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Assets.icons.orders.svg(width: 115.0),
          const SpaceHeight(4.0),
          const Text(
            "Belum Ada Produk",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}