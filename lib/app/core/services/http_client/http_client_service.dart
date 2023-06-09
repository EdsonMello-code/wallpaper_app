import 'package:test_two/app/core/services/http_client/response.dart';

abstract class HttpClientService {
  Future<List<int>> getFileInBytes(
    String urlOfFile,
  );

  Future<CustomResponse> get(
    String url, [
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  ]);
}
