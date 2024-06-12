import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/home/models/product_category.dart';
import 'package:possapp/presentation/home/models/product_model.dart';
import 'package:possapp/presentation/setting/pages/add_product_page.dart';
import 'package:possapp/presentation/setting/widgets/menu_product_item.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final List<ProductModel> products = [
    ProductModel(
      image: Assets.images.f1.path,
      name: "Vanilla Latte",
      category: ProductCategory.drink,
      price: 50000,
      stock: 40,
    ),
    ProductModel(
      image: Assets.images.f2.path,
      name: "Latte",
      category: ProductCategory.drink,
      price: 55000,
      stock: 42,
    ),
    ProductModel(
      image: Assets.images.f3.path,
      name: "Americano",
      category: ProductCategory.drink,
      price: 60000,
      stock: 51,
    ),
    ProductModel(
      image: Assets.images.f4.path,
      name: "Cappucino",
      category: ProductCategory.drink,
      price: 65000,
      stock: 25,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Produk',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'List Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                success: (products) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: ((context, index) =>
                        const SpaceHeight(20)),
                    itemBuilder: (context, index) => MenuProductItem(
                      data: products[index],
                    ),
                  );
                },
              );
              // return ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: products.length,
              //   separatorBuilder: (context, index) => const SpaceHeight(20),
              //   itemBuilder: (context, index) => MenuProductItem(
              //     data: products[index],
              //   ),
              // );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
