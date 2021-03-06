import 'package:test_two/app/core/services/http_client/http_client_service.dart';
import 'package:test_two/app/core/services/local_path/local_path_service.dart';
import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';
import 'package:test_two/app/modules/home/externals/mappers/wallpaper_mapper.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_datasource.dart';

import '../../../../core/services/permission/permission_service.dart';

class WallpaperDatasourceImpl implements WallpaperDatasource {
  final HttpClientService _httpClientService;
  final LocalPathService _localPath;
  final PermissionService _permission;

  const WallpaperDatasourceImpl(
    this._httpClientService,
    this._localPath,
    this._permission,
  );

  @override
  Future<List<WallpaperEntity>> getWallpapersDatasource() async {
    print(const String.fromEnvironment('key') + 'Teste');
    final response = await _httpClientService.get(
      '/curated',
      {'Authorization': 'Bearer ${const String.fromEnvironment('key')}'},
      {
        'per_page': 100,
      },
    );
    final data = List<Map<String, dynamic>>.from(
      response.data['photos'],
    );

    final wallpapers = data
        .map(
          (wallpaperMap) => WallpaperMapper.fromMap(
            wallpaperMap,
          ),
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
        'Authorization': 'Bearer ${const String.fromEnvironment('key')}',
      },
      {
        'query': subject,
        'per_page': 100,
      },
    );

    final data = List<Map<String, dynamic>>.from(
      response.data['photos'],
    );

    final wallpapers = data
        .map(
          (wallpaperMap) => WallpaperMapper.fromMap(
            wallpaperMap,
          ),
        )
        .toList();

    return wallpapers;
  }

  @override
  Future<bool> downloadWallpaperDatasource(String url) async {
    final storagePermissionStatus = await _permission.getStoragePermission();

    if (storagePermissionStatus == false) {
      throw const WallpaperInternetError(
        'Preciso da sua permiss??o para salvar as images',
      );
    }

    final path = await _localPath.getDownloadPath();
    final isImageSaved = _httpClientService.downloadFile(url, path);
    return isImageSaved;
  }
}
