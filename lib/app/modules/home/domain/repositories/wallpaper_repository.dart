import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

import '../../../../core/utils/either.dart';

abstract class WallpaperRepository {
  Future<Either<WallpaperError, List<WallpaperEntity>>> getWallpappers();

  Future<Either<WallpaperError, List<WallpaperEntity>>> getWallpappersBySubject(
    String subject,
  );

  Future<Either<WallpaperError, bool>> downloadWallpapers(
    String url,
  );
}
