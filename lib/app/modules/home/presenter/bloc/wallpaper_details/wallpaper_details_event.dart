abstract class WallpaperDetailsEvent {}

class SaveWallpaperEvent implements WallpaperDetailsEvent {
  final String url;

  const SaveWallpaperEvent(this.url);
}
