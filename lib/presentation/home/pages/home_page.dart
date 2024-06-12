import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/menu_button.dart';
import 'package:possapp/core/components/search_input.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/home/models/product_model.dart';
import 'package:possapp/presentation/home/widgets/product_card.dart';
import 'package:possapp/presentation/home/widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);

  List<ProductModel> searchResults = [];
  // final List<ProductModel> products = [
  //   ProductModel(
  //     image: Assets.images.f1.path,
  //     name: 'Kopi Latte',
  //     category: ProductCategory.drink,
  //     price: 40000,
  //     stock: 10,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f6.path,
  //     name: 'Cappucino',
  //     category: ProductCategory.drink,
  //     price: 45000,
  //     stock: 20,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f8.path,
  //     name: 'Hot Tea',
  //     category: ProductCategory.drink,
  //     price: 30000,
  //     stock: 15,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f5.path,
  //     name: 'Iced Mocha',
  //     category: ProductCategory.drink,
  //     price: 50000,
  //     stock: 30,
  //   ),
  // ];

  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.fetchLocal());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear(); //kalo kategori di tap, maka yg dari fitur search ke clear
    indexValue.value = index;
    String category = 'all';
    switch (index) {
      case 0:
        category = 'all';
        break;
      case 1:
        category = 'drink';
        break;
      case 2:
        category = 'food';
        break;
      case 3:
        category = 'snack';
        break;
    }
    context.read<ProductBloc>().add(ProductEvent.fetchByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SearchInput(
              controller: searchController,
              onChanged: (value) {
                
                if (value.length >= 1) {
                  context
                      .read<ProductBloc>()
                      .add(ProductEvent.searchProduct(value));
                }

                if (value.isEmpty) {
                  context
                      .read<ProductBloc>()
                      .add(const ProductEvent.fetchAllFromState());
                }
              },
            ),
            const SpaceHeight(20.0),
            ValueListenableBuilder(
              valueListenable: indexValue,
              builder: (context, value, _) => Row(
                children: [
                  MenuButton(
                    iconPath: Assets.icons.allCategories.path,
                    label: 'All',
                    isActive: value == 0,
                    onPressed: () => onCategoryTap(0),
                  ),
                  const SpaceWidth(10.0),
                  MenuButton(
                    iconPath: Assets.icons.drink.path,
                    label: 'Minuman',
                    isActive: value == 1,
                    onPressed: () => onCategoryTap(1),
                  ),
                  const SpaceWidth(10.0),
                  MenuButton(
                    iconPath: Assets.icons.food.path,
                    label: 'Makanan',
                    isActive: value == 2,
                    onPressed: () => onCategoryTap(2),
                  ),
                  const SpaceWidth(10.0),
                  MenuButton(
                    iconPath: Assets.icons.snack.path,
                    label: 'Snack',
                    isActive: value == 3,
                    onPressed: () => onCategoryTap(3),
                  ),
                ],
              ),
            ),
            const SpaceHeight(35.0),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SizedBox();
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (message) {
                    return Center(
                      child: Text(message),
                    );
                  },
                  success: (products) {
                    if (products.isEmpty) return const ProductEmpty();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.70,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        data: products[index],
                        onCartButton: () {},
                      ),
                    );
                  },
                );
                // return GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: searchResults.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     childAspectRatio: 0.65,
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 30.0,
                //     mainAxisSpacing: 30.0,
                //   ),
                //   itemBuilder: (context, index) => ProductCard(
                //     // data: searchResults[index],
                //     onCartButton: () {},
                //   ),
                // );
              },
            ),
            const SpaceHeight(30.0),
          ],
        ),
      ),
    );
  }
}
