import 'package:dio/dio.dart';
import 'package:matjar/core/network/api_error.dart';
import 'package:matjar/core/network/api_exception.dart';
import 'package:matjar/core/network/api_service.dart';
import 'package:matjar/features/home/data/product_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  ProductRepo();

  //Get Products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get('/products/');
      return (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Update Product
  Future<dynamic> updateProduct(int id, Map<String, dynamic> body) async {
    try {
      final response = await _apiService.put('products/$id', body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Delete Product
  Future<dynamic> deleteProduct(int id) async {
    try {
      final response = await _apiService.delete('products/$id', {});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
