abstract class WallpaperError implements Exception {
  abstract final String message;
}

class WallpaperInternetError implements WallpaperError {
  @override
  final String message;

  const WallpaperInternetError(this.message);
}
