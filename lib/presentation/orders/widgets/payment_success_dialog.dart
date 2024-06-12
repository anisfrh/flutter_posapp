import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/buttins.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/build_context_ext.dart';
import 'package:possapp/core/extensions/date_time_ext.dart';
import 'package:possapp/core/extensions/int_ext.dart';
import 'package:possapp/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:possapp/presentation/home/pages/dashboard_page.dart';
import 'package:possapp/presentation/orders/bloc/order/order_bloc.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.highlight_off, size: 24),
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 64,
              height: 64,
              child: Assets.icons.done.svg(),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pembayaran Telah Sukses Dilakukan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              success:
                  (data, qty, total, paymentType, nominal, idKasir, namaKasir) {
                context.read<CheckoutBloc>().add(const CheckoutEvent.started());

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpaceHeight(12),
                    _LabelValue(
                      label: 'METODE BAYAR',
                      value: paymentType,
                    ),
                    const Divider(
                      height: 36,
                    ),
                    _LabelValue(
                      label: 'TOTAL PEMBELIAN',
                      value: total.currencyFormatRp,
                    ),
                    const Divider(
                      height: 36,
                    ),
                    _LabelValue(
                      label: 'NOMINAL PEMBAYARAN',
                      value: paymentType == 'QRIS'
                          ? total.currencyFormatRp
                          : nominal.currencyFormatRp,
                    ),
                    const Divider(
                      height: 36,
                    ),
                    _LabelValue(
                      label: 'WAKTU PEMBAYARAN',
                      value: DateTime.now().toFormattedTime(),
                    ),
                    const SpaceHeight(40.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Button.filled(
                            onPressed: () {
                              // Biar nge build ulang, kalau pembelian selesai, dia akan balik ke dashboard dengan keadaan awal
                              // alias kosong, pembelian mulai dari awal lagi
                              context.read<OrderBloc>().add(const OrderEvent.started());
                              context
                                  .pushReplacement(const DashboardPageState());
                            },
                            label: 'Selesai',
                            fontSize: 14,
                          ),
                        ),
                        const SpaceWidth(10),
                        Flexible(
                          child: Button.outlined(
                            onPressed: () async {
                              // final ticket = await CwbPrint.instance.bluetoothStart();
                              // final result = await PrintBluetoothThermal.writeBytes(ticket);
                            },
                            label: 'Print',
                            icon: Assets.icons.print.svg(),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SpaceHeight(5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
