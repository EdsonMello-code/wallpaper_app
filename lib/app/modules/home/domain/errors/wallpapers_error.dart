import 'package:test_two/app/core/app_failure/app_failure.dart';

abstract interface class WallpaperError implements AppFailure {
  @override
  abstract final String message;
}

class WallpaperInternetError implements WallpaperError {
  @override
  final String message;

  const WallpaperInternetError(this.message);
}
