import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:possapp/core/constants/variables.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/models/request/product_request_model.dart';
import 'package:possapp/data/models/response/add_product_response_model.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/products'));
    request.fields.addAll(productRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', productRequestModel.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
