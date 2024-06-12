import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/int_ext.dart';
import 'package:possapp/presentation/home/bloc/checkout/checkout_bloc.dart';

class ProcessButton extends StatelessWidget {
  final int price;
  final VoidCallback onPressed;

  const ProcessButton({
    super.key,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: AppColors.primary,
        ),
        child: Row(
          children: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return const Text(
                    'Rp. 0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }, success: (data, qty, total) {
                  return Text(
                    total.currencyFormatRp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                });
              },
            ),
            const Spacer(),
            const Text(
              'Proses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(5),
            const Icon(
              Icons.chevron_right,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
