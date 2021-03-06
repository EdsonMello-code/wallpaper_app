import 'package:test_two/app/core/services/http_client/http_error.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';

import 'package:fpdart/src/either.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_datasource.dart';

import '../../domain/repositories/wallpaper_repository.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperDatasource _wallpaperDatasource;

  const WallpaperRepositoryImpl(this._wallpaperDatasource);

  @override
  Future<Either<WallpaperError, List<WallpaperEntity>>> getWallpappers() async {
    try {
      final wallpapers = await _wallpaperDatasource.getWallpapersDatasource();
      return Right(wallpapers);
    } on HttpError catch (error) {
      return Left(
        WallpaperInternetError(error.message),
      );
    }
  }

  @override
  Future<Either<WallpaperError, List<WallpaperEntity>>> getWallpappersBySubject(
    String subject,
  ) async {
    try {
      final wallpapers =
          await _wallpaperDatasource.getWallpapersBySubjectDatasource(
        subject,
      );

      return Right(wallpapers);
    } on HttpError catch (error) {
      return Left(
        WallpaperInternetError(error.message),
      );
    }
  }

  @override
  Future<Either<WallpaperError, bool>> downloadWallpapers(String url) async {
    try {
      final isSavedWallpaper =
          await _wallpaperDatasource.downloadWallpaperDatasource(
        url,
      );

      return Right(isSavedWallpaper);
    } on HttpError catch (error) {
      return Left(
        WallpaperInternetError(
          error.message,
        ),
      );
    }
  }
}
