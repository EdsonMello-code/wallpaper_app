import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

abstract class WallpapersState {}

class WallpaperStartState implements WallpapersState {}

class WallpaperLoadingState implements WallpapersState {}

class WallpaperSuccessState implements WallpapersState {
  final List<WallpaperEntity> wallpapers;

  const WallpaperSuccessState({
    required this.wallpapers,
  });
}

class WallpapperFailureState implements WallpapersState {
  final String message;

  const WallpapperFailureState({
    required this.message,
  });
}
