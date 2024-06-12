import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/presentation/history/bloc/history/history_bloc.dart';
import 'package:possapp/presentation/history/models/history_transaction_model.dart';
import 'package:possapp/presentation/history/widgets/history_transaction_card.dart';
import 'package:possapp/presentation/orders/models/order_models.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const HistoryEvent.fetch());
  }

  // final List<HistoryTransactionModel> historyTransactions = [
  // //   HistoryTransactionModel(
  // //     name: 'Payment 1',
  // //     category: 'Category A',
  // //     price: 200000,
  // //   ),
  // //   HistoryTransactionModel(
  // //     name: 'Payment 2',
  // //     category: 'Category B',
  // //     price: 200000,
  // //   ),
  // //   HistoryTransactionModel(
  // //     name: 'Payment 3',
  // //     category: 'Category C',
  // //     price: 200000,
  // //   ),
  // // ];
  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History Page',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: Text('No Data'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, success: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SpaceHeight(30),
              itemBuilder: (context, index) => HistoryTransactionCard(
                padding: paddingHorizontal,
                data: data[index],
              ),
            );
          });
        },
      ),
    );
  }
}
