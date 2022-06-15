import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_two/app/modules/home/domain/repositories/wallpaper_repository.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_usecase.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

void main() {
  late GetWallpapersUsecase getWallpapersUsecase;
  late WallpaperRepository wallpaperRepository;

  setUp(() {
    wallpaperRepository = WallpaperRepositoryMock();
    getWallpapersUsecase = GetWallpapersUsecase(wallpaperRepository);
  });

  group(
    'Get wallpapers usecase',
    () {
      test(
        'Should get wallpapers then this method is called!',
        () async {
          when(
            () => wallpaperRepository.getWallpappers(),
          ).thenAnswer(
            (_) => Future.value(
              Either.right(
                wallpapersListWithDataFormated,
              ),
            ),
          );

          final responseWallpapers = await getWallpapersUsecase();

          responseWallpapers.fold(
            (leftWallpapers) {
              expect(leftWallpapers, isNull);
            },
            (rigthWallpapers) {
              expect(rigthWallpapers, isNotEmpty);
              expect(rigthWallpapers, isA<List<WallpaperEntity>>());
            },
          );
        },
      );

      test(
        'Should get wallpapers with size of image correct then this method is called!',
        () async {
          when(
            () => wallpaperRepository.getWallpappers(),
          ).thenAnswer(
            (_) => Future.value(
              Either.right(
                wallpapersListWithDataFormated,
              ),
            ),
          );

          final responseWallpapers = await getWallpapersUsecase();

          responseWallpapers.fold(
            (leftWallpapers) {
              expect(leftWallpapers, isNull);
            },
            (rigthWallpapers) {
              expect(
                rigthWallpapers[0].imageMedium.contains('h=350'),
                equals(true),
              );
            },
          );
        },
      );

      test(
        'Should throw error with size of image is not correct then this method is called!',
        () async {
          when(
            () => wallpaperRepository.getWallpappers(),
          ).thenAnswer(
            (_) => Future.value(
              Either.right(
                wallpapersListWithDataNotFormated,
              ),
            ),
          );

          final responseWallpapers = await getWallpapersUsecase();

          responseWallpapers.fold(
            (leftWallpapers) {
              expect(leftWallpapers, isNull);
            },
            (rigthWallpapers) {
              expect(
                !rigthWallpapers[0].imageMedium.contains('h=350'),
                equals(true),
              );
            },
          );
        },
      );
    },
  );
}

class WallpaperRepositoryMock extends Mock implements WallpaperRepository {}

final List<WallpaperEntity> wallpapersListWithDataFormated = [
  const WallpaperEntity(
    imageMedium:
        'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350',
    imageOriginal:
        'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg',
    extraLarge: '',
  )
];

final List<WallpaperEntity> wallpapersListWithDataNotFormated = [
  const WallpaperEntity(
    imageMedium:
        'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb',
    imageOriginal:
        'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg',
    extraLarge: '',
  )
];
