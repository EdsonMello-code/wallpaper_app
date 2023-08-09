import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_two/app/core/utils/either.dart';
import 'package:test_two/app/modules/home/domain/errors/wallpapers_error.dart';
import 'package:test_two/app/modules/home/domain/repositories/wallpaper_repository.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_by_subject_usecase.dart';
import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

void main() {
  late GetWallpapersBySubjectUsecase getWallpapersBySubjectUsecase;
  late WallpaperRepository wallpaperRepository;

  setUp(() {
    wallpaperRepository = WallpaperRepositoryMock();

    getWallpapersBySubjectUsecase =
        GetWallpapersBySubjectUsecase(wallpaperRepository);
  });
  group('Get wallpapers by subject usecase', () {
    test(
      'Should return wallpapers by subject then this method is called.',
      () async {
        when(
          () => wallpaperRepository.getWallpappersBySubject(
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Right(
              wallpapersListWithDataFormated,
            ),
          ),
        );

        final wallpapersResponse =
            await wallpaperRepository.getWallpappersBySubject('Nature');

        wallpapersResponse.fold(left: (wallpaperLeft) {
          expect(wallpaperLeft, isNull);
        }, right: (wallpaperRight) {
          expect(wallpaperRight, isA<List<WallpaperEntity>>());
          expect(
            wallpaperRight.isNotEmpty,
            equals(true),
          );
        });
      },
    );

    test(
      'Should return error then get wallpapers by subject then this method is called.',
      () async {
        when(
          () => wallpaperRepository.getWallpappersBySubject(
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            const Left(
              WallpaperInternetError(
                'Error ao procura wallpapers com esse assunto',
              ),
            ),
          ),
        );

        final wallpapersResponse = await getWallpapersBySubjectUsecase('');

        wallpapersResponse.fold(left: (wallpaperLeft) {
          expect(wallpaperLeft, isNotNull);
          expect(wallpaperLeft, isException);
          expect(
            wallpaperLeft,
            isA<WallpaperInternetError>(),
          );
        }, right: (wallpaperRight) {
          expect(wallpaperRight, isNull);
        });
      },
    );
  });
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
