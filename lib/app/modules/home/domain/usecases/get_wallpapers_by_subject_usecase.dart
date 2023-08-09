import '../../../../core/utils/either.dart';
import '../errors/wallpapers_error.dart';
import '../repositories/wallpaper_repository.dart';
import '../wallpaper_entity.dart';

abstract class IGetWallpapersBySubjectUsecase {
  Future<Either<WallpaperError, List<WallpaperEntity>>> call(String subject);
}

class GetWallpapersBySubjectUsecase implements IGetWallpapersBySubjectUsecase {
  final WallpaperRepository _wallpaperRepository;

  const GetWallpapersBySubjectUsecase(this._wallpaperRepository);

  @override
  Future<Either<WallpaperError, List<WallpaperEntity>>> call(String subject) {
    return _wallpaperRepository.getWallpappersBySubject(
      subject.isEmpty ? 'Car' : subject,
    );
  }
}
