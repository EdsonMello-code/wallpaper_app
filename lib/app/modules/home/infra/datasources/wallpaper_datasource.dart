import 'package:test_two/app/modules/home/infra/datasources/wallpapper_datasource_base.dart';

abstract interface class WallpaperDatasource
    implements WallpaperDatasourceBase {
  Future<bool> downloadWallpaperDatasource(
    String url,
  );
  Future<List<Map<String, dynamic>>> getWallpapersBySubjectDatasource(
    String subject,
  );
}
