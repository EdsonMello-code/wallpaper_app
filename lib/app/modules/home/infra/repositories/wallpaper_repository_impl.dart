import 'package:fpdart/fpdart.dart';
import 'package:test_two/app/core/app_failure/app_failure.dart';
import 'package:test_two/app/core/services/permission/permission_service.dart';
import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_datasource.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_offline_datasource.dart';

import '../../domain/repositories/wallpaper_repository.dart';
import '../../externals/mappers/wallpaper_mapper.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperDatasource _wallpaperDatasource;
  final WallpapperOfflineDatasource _wallpapperOfflineDatasource;

  final PermissionService _permission;

  const WallpaperRepositoryImpl(
    this._wallpaperDatasource,
    this._permission,
    this._wallpapperOfflineDatasource,
  );

  @override
  Future<Either<WallpaperError, List<WallpaperEntity>>> getWallpappers() async {
    try {
      final wallpappersOfflineMap =
          await _wallpapperOfflineDatasource.getWallpapersDatasource();

      late final List<Map<String, dynamic>> wallpapersMap;

      if (wallpappersOfflineMap.isNotEmpty) {
        wallpapersMap = wallpappersOfflineMap;
      } else {
        wallpapersMap = await _wallpaperDatasource.getWallpapersDatasource();
        _wallpapperOfflineDatasource.saveWallpapers(wallpapersMap);
      }

      final wallpapers = wallpapersMap
          .map(
            WallpaperMapper.fromMap,
          )
          .toList();
      return Right(wallpapers);
    } on AppFailure catch (error) {
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
      final wallpapersMap =
          await _wallpaperDatasource.getWallpapersBySubjectDatasource(
        subject,
      );

      final wallpapers = wallpapersMap
          .map(
            WallpaperMapper.fromMap,
          )
          .toList();

      return Right(wallpapers);
    } on AppFailure catch (error) {
      return Left(
        WallpaperInternetError(error.message),
      );
    }
  }

  @override
  Future<Either<WallpaperError, bool>> downloadWallpapers(String url) async {
    try {
      final storagePermissionStatus = await _permission.getStoragePermission();

      if (storagePermissionStatus == false) {
        return const Left(
          WallpaperInternetError(
            'Preciso da sua permissão para salvar as images',
          ),
        );
      }
      final isSavedWallpaper =
          await _wallpaperDatasource.downloadWallpaperDatasource(
        url,
      );

      return Right(isSavedWallpaper);
    } on AppFailure catch (error) {
      return Left(
        WallpaperInternetError(
          error.message,
        ),
      );
    }
  }
}
