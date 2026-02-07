import 'package:dio/dio.dart';
import 'package:matjar/core/network/api_exception.dart';
import 'package:matjar/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  //CRUD METHODS

  //get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  //post
  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  //put
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  //delete
  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }
}
