import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

sealed class WallpapersState {}

class WallpaperStartState implements WallpapersState {}

class WallpaperLoadingState implements WallpapersState {}

class WallpaperSuccessState implements WallpapersState {
  final List<WallpaperEntity> wallpapers;

  WallpaperSuccessState({
    required this.wallpapers,
  });
}

class WallpapperFailureState implements WallpapersState {
  final String message;

  WallpapperFailureState({
    required this.message,
  });
}
