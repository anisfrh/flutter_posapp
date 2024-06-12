part of 'product_bloc.dart';

//step1
//event buat namaFunction

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  // ini untuk fetch / ambil data dari api
  const factory ProductEvent.fetch() = _Fetch;
  // ini untuk ambil data dari api dan di filter berdasarkan kategori
  const factory ProductEvent.fetchByCategory(String category) = _FetchByCategory;
  // Fetch data produk dari lokal
  const factory ProductEvent.fetchLocal() = _FetchLocal;
  // Add data produk
  const factory ProductEvent.addProduct(Product product, XFile image) = _AddProduct;
  // Search Product
  const factory ProductEvent.searchProduct(String query) = _SearchProduct;
  // fetch from state
  const factory ProductEvent.fetchAllFromState() = _FetchAllFromState;

}