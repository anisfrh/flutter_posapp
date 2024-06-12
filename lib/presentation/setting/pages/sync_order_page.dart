import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/setting/bloc/sync_order/sync_order_bloc.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sync Data',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Button sync data product
           BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                state.maybeMap(
                    orElse: () {},
                    success: (_) async {
                      await ProductLocalDatasource.instance.removeAllProduct();
                      await ProductLocalDatasource.instance
                          .insertAllProduct(_.products.toList());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.primary,
                          content: Text(
                            'Sinkronisasi Data Produk Berhasil',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    });
              },
              builder: (context, state) {
                // Harusnya keyika proses async atau ambil data, dia reload
                return state.maybeWhen(
                  orElse: () {
                    return ElevatedButton(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(const ProductEvent.fetch());
                        },
                        child: const Text('Sync Data Produk'));
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
            const SpaceHeight(20),
             BlocConsumer<SyncOrderBloc, SyncOrderState>(
              listener: (context, state) {
                state.maybeMap(
                    orElse: () {},
                    success: (_) async {
                      // await ProductLocalDatasource.instance.removeAllProduct();
                      // await ProductLocalDatasource.instance
                      //     .insertAllProduct(_.products.toList());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.primary,
                          content: Text(
                            'Sinkronisasi Data Order Berhasil',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    });
              },
              builder: (context, state) {
                // Harusnya keyika proses async atau ambil data, dia reload
                return state.maybeWhen(
                  orElse: () {
                    return ElevatedButton(
                        onPressed: () {
                          context
                              .read<SyncOrderBloc>()
                              .add(const SyncOrderEvent.sendOrder());
                        },
                        child: const Text('Sync Data Orders'));
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
