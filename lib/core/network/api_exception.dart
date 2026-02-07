import 'package:dio/dio.dart';
import 'package:matjar/core/network/api_error.dart';

class ApiException {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }

    switch (error.type) {
      case DioException.connectionTimeout:
        return ApiError(message: "Bad Connetion ,please try again");
      case DioException.badResponse:
        return ApiError(message: error.message.toString());
      case DioException.sendTimeout:
        return ApiError(message: "Request Timeout ,please try again");
      case DioException.receiveTimeout:
        return ApiError(message: "Response Timeout ,please try again");
      case DioExceptionType.cancel:
        return ApiError(message: "Request cancelled");
      default:
        return ApiError(message: "Something went wrong ,please try again");
    }
  }
}
