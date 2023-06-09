import 'package:test_two/app/core/services/http_client/http_client_service.dart';
import 'package:test_two/app/core/services/http_client/response.dart';
import 'package:uno/uno.dart';

class HttpClientUnoServiceImpl implements HttpClientService {
  final Uno uno;

  const HttpClientUnoServiceImpl({
    required this.uno,
  });

  @override
  Future<bool> downloadFile(
    String urlOfFile,
    String localToSaveInDevice,
  ) async {
    await uno.get(urlOfFile, responseType: ResponseType.arraybuffer);
    return true;
  }

  @override
  Future<CustomResponse> get(
    String url, [
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  ]) async {
    final response = await uno.get(
      url,
      responseType: ResponseType.json,
      headers: Map<String, String>.from(
        headers ?? <String, String>{},
      ),
    );

    return CustomResponse(response.data);
  }
}
