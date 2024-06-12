// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/data/datasources/product_remote_datasource.dart';
import 'package:possapp/data/models/request/product_request_model.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

//step 3
//dibloc baru diperjrlas langkah"nya
// blocdigunakan untuk mempermudah(misah") buat bikin function atau state(misal loading ngapain, gini ngapain)

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDataSource;
  // Untuk Ambil data produk
  List<Product> products = [];
  ProductBloc(
    this._productRemoteDataSource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemoteDataSource.getProducts();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    // Ini untuk Fetch Data Lokal
    on<_FetchLocal>((event, emit) async {
      final localProducts =
          await ProductLocalDatasource.instance.getAllProduct();
      products = localProducts;
      emit(ProductState.success(products));
    });

    // Ini untuk filter data berdasarkan kategori
    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();

      emit(ProductState.success(newProduct));
    });

    on<_AddProduct>((event, emit) async {
      emit(const ProductState.loading());
      final requestData = ProductRequestModel(
        name: event.product.name,
        price: event.product.price,
        stock: event.product.stock,
        category: event.product.category,
        isBestSeller: event.product.isBestSeller ? 1 : 0,
        image: event.image,
      );
      final response = await _productRemoteDataSource.addProduct(requestData);
      response.fold((l) => emit(ProductState.error(l)), (r) {
        products.add(r.data);
        emit(ProductState.success(products));
      });

      emit(ProductState.success(products));
    });

    // Ini buat search data product
    on<_SearchProduct>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = products
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductState.success(newProduct));
    });

    // Ini buat ngembaliin ke halaman awal
    on<_FetchAllFromState>((event, emit) async {
      emit(const ProductState.loading());

      emit(ProductState.success(products));
    });
  }
}



// maybeMap return aksi yg ada di state, cuma sekedarnya ex: return succes. udh kelar
// kalo maybeWhen bawa data yg ada di state tapi lebih kompleks