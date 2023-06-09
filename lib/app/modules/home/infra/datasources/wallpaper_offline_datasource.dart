import 'package:test_two/app/core/utils/unit.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpapper_datasource_base.dart';

abstract interface class WallpapperOfflineDatasource
    implements WallpaperDatasourceBase {
  Future<Unit> saveWallpapers(List<Map<String, dynamic>> map);
}
