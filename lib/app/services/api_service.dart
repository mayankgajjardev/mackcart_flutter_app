import 'package:dio/dio.dart';
import 'package:mack_cart_app/app/constants/app_constants.dart';
import 'package:mack_cart_app/app/constants/app_enums.dart';
import 'package:mack_cart_app/app/services/api_result.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// An HTTP request using Dio.
  static Future<ApiResult<T>> request<T>({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? parseJson,
    bool isLoading = true,
  }) async {
    try {
      final options = Options(
        method: method.value,
        headers: headers,
      );

      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      final result =
          parseJson != null ? parseJson(response.data) : response.data as T;
      return ApiSuccess(result);
    } on DioException catch (e) {
      return ApiError(handleError(e));
    } catch (e) {
      return ApiError('Unexpected Error: $e');
    }
  }

  static String handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (e.type == DioExceptionType.sendTimeout) {
      return 'Send timeout';
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode ?? 0;
      final message = e.response?.data.toString() ?? 'Unknown error';
      return 'HTTP $statusCode: $message';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request cancelled';
    } else {
      return 'Unexpected Dio error: ${e.message}';
    }
  }
}
