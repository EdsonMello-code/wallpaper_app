import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

abstract class WallpaperDatasource {
  Future<List<WallpaperEntity>> getWallpapersDatasource();
  Future<List<WallpaperEntity>> getWallpapersBySubjectDatasource(
    String subject,
  );

  Future<bool> downloadWallpaperDatasource(
    String url,
  );
}
