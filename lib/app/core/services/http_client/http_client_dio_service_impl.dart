import 'package:dio/dio.dart';
import 'package:test_two/app/core/services/http_client/http_client_service.dart';
import 'package:test_two/app/core/services/http_client/response.dart';

import 'http_error.dart';

class HttpClientDioServiceImpl implements HttpClientService {
  final Dio _dio;

  @override
  final String baseUrl;

  const HttpClientDioServiceImpl(
    this._dio,
    this.baseUrl,
  );

  Dio get httpClient => Dio(
        BaseOptions(
          baseUrl: baseUrl,
        ),
      );

  @override
  Future<bool> downloadFile(String urlOfFile, localToSaveInDevice) async {
    try {
      final response = await httpClient.download(
        urlOfFile,
        localToSaveInDevice + DateTime.now().millisecond.toString() + '.jpg',
      );

      if (response.data != null) {
        return false;
      }

      return false;
    } on DioError catch (error) {
      throw HttpError(error.message);
    }
  }

  @override
  Future<CustomResponse> get(
    String url, [
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  ]) async {
    try {
      final response = await _dio.get(
        baseUrl + url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      );
      return CustomResponse(response.data);
    } on DioError catch (error) {
      throw HttpError(error.message);
    }
  }
}
