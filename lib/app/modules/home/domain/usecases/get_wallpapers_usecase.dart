import 'package:fpdart/fpdart.dart';
import 'package:test_two/app/modules/home/domain/repositories/wallpaper_repository.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

import '../errors/wallpapers_error.dart';

abstract class IGetWallpapersUsecase {
  Future<Either<WallpaperError, List<WallpaperEntity>>> call();
}

class GetWallpapersUsecase implements IGetWallpapersUsecase {
  final WallpaperRepository _wallpaperRepository;

  const GetWallpapersUsecase(this._wallpaperRepository);

  @override
  Future<Either<WallpaperError, List<WallpaperEntity>>> call() {
    return _wallpaperRepository.getWallpappers();
  }
}
