import 'package:matjar/core/network/api_service.dart';
import 'package:matjar/features/home/data/product_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  ProductRepo();

  //Get Products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get('/products/');
      if (response is List) {
        return response
            .map((product) => ProductModel.fromJson(product))
            .toList();
      }
      return [];
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
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
      // نرسل طلب حذف للمسار products/id
      final response = await _apiService.delete('products/$id', {});
      return response;
    } catch (e) {
      rethrow; // نرمي الخطأ ليمسكه الكيوبت
    }
  }
}
