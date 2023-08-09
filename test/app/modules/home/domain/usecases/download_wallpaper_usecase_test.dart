import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_two/app/core/utils/either.dart';
import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';
import 'package:test_two/app/modules/home/domain/repositories/wallpaper_repository.dart';
import 'package:test_two/app/modules/home/domain/usecases/download_wallpaper_usecase.dart';

void main() {
  late DownloadWallpaperUsecase downloadWallpaperUsecase;
  late WallpaperRepository wallpaperRepository;

  setUp(
    () {
      wallpaperRepository = WallpaperRepositoryMock();
      downloadWallpaperUsecase = DownloadWallpaperUsecase(
        wallpaperRepository,
      );
    },
  );
  test(
    'Should download image then this method is called.',
    () async {
      when(
        () => wallpaperRepository.downloadWallpapers(
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          const Right(true),
        ),
      );

      final downloadedImageResponse = await downloadWallpaperUsecase(
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      );

      downloadedImageResponse.fold(left: (wallaperLeft) {
        expect(wallaperLeft, isNull);
      }, right: (wallaperRight) {
        expect(wallaperRight, isNotNull);
        expect(wallaperRight, isA<bool>());
        expect(wallaperRight, isTrue);
      });
    },
  );

  test(
    'Should not download image and return is false then this method is called .',
    () async {
      when(
        () => wallpaperRepository.downloadWallpapers(
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          const Right(false),
        ),
      );

      final downloadedImageResponse = await downloadWallpaperUsecase(
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      );

      downloadedImageResponse.fold(left: (wallaperLeft) {
        expect(wallaperLeft, isNull);
      }, right: (wallaperRight) {
        expect(wallaperRight, isNotNull);
        expect(wallaperRight, isA<bool>());
        expect(wallaperRight, isFalse);
      });
    },
  );

  test(
    'Should throw error [WallpaperError] download image and return is false then this method is called .',
    () async {
      when(
        () => wallpaperRepository.downloadWallpapers(
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          const Left(
            WallpaperInternetError('Download not download'),
          ),
        ),
      );

      final downloadedImageResponse = await downloadWallpaperUsecase(
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      );

      downloadedImageResponse.fold(left: (wallaperLeft) {
        expect(wallaperLeft, isNotNull);
        expect(wallaperLeft, isA<WallpaperInternetError>());
      }, right: (wallaperRight) {
        expect(wallaperRight, isNull);
      });
    },
  );
}

class WallpaperRepositoryMock extends Mock implements WallpaperRepository {}
