import 'package:test_two/app/core/services/http_client/response.dart';

abstract class HttpClientService {
  abstract final String baseUrl;
  Future<bool> downloadFile(String urlOfFile, String localToSaveInDevice);

  Future<CustomResponse> get(
    String url, [
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  ]);
}
