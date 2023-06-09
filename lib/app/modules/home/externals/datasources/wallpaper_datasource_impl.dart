import 'package:test_two/app/core/services/http_client/http_client_service.dart';
import 'package:test_two/app/core/services/local_path/local_path_service.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';
import 'package:test_two/app/modules/home/externals/mappers/wallpaper_mapper.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_datasource.dart';

class WallpaperDatasourceImpl implements WallpaperDatasource {
  final HttpClientService _httpClientService;
  final LocalPathService _localPath;

  static const _key = String.fromEnvironment('key');

  const WallpaperDatasourceImpl(
    this._httpClientService,
    this._localPath,
  );

  @override
  Future<List<WallpaperEntity>> getWallpapersDatasource() async {
    final response = await _httpClientService.get(
      '/curated',
      {
        'Authorization': _key,
      },
      {
        'per_page': 100.toString(),
      },
    );
    final data = List<Map<String, dynamic>>.from(
      response.data['photos'],
    );

    final wallpapers = data
        .map(
          WallpaperMapper.fromMap,
        )
        .toList();

    return wallpapers;
  }

  @override
  Future<List<WallpaperEntity>> getWallpapersBySubjectDatasource(
    String subject,
  ) async {
    final response = await _httpClientService.get(
      '/search',
      {
        'Authorization': _key,
      },
      {
        'query': subject.trim(),
      },
    );

    final data = List<Map<String, dynamic>>.from(
      response.data['photos'],
    );

    final wallpapers = data.map(WallpaperMapper.fromMap).toList();

    return wallpapers;
  }

  @override
  Future<bool> downloadWallpaperDatasource(String url) async {
    final path = await _localPath.getDownloadPath();
    final isImageSaved = _httpClientService.downloadFile(url, path);
    return isImageSaved;
  }
}
