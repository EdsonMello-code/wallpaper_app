import '../../../../core/utils/either.dart';
import '../errors/wallpapers_error.dart';
import '../repositories/wallpaper_repository.dart';

abstract interface class IDownloadWallpaperUsecase {
  Future<Either<WallpaperError, bool>> call(String url);
}

class DownloadWallpaperUsecase implements IDownloadWallpaperUsecase {
  final WallpaperRepository _wallpaperRepository;

  const DownloadWallpaperUsecase(this._wallpaperRepository);

  @override
  Future<Either<WallpaperError, bool>> call(String url) {
    return _wallpaperRepository.downloadWallpapers(url);
  }
}
