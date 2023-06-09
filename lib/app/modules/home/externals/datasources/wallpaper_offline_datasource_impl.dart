import 'package:test_two/app/core/services/local_storage/local_storage.dart';
import 'package:test_two/app/core/utils/unit.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_offline_datasource.dart';

const _wallpapperKey = 'wallpaper';

class WallpapperOfflineDatasourceImpl implements WallpapperOfflineDatasource {
  final LocalStorage localStorage;

  WallpapperOfflineDatasourceImpl(this.localStorage);

  @override
  Future<List<Map<String, dynamic>>> getWallpapersDatasource() async {
    final response = await localStorage.get(_wallpapperKey);

    final wallpapers = List<dynamic>.from(response ?? []);
    final wallpappersMap = wallpapers.map((wallpaper) {
      return Map<String, dynamic>.from(wallpaper);
    }).toList();
    return wallpappersMap;
  }

  @override
  Future<Unit> saveWallpapers(List<Map<String, dynamic>> map) async {
    await localStorage.put(_wallpapperKey, map);
    return unit;
  }
}
