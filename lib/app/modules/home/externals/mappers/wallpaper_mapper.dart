import 'package:test_two/app/modules/home/domain/wallpaper_entity.dart';

class WallpaperMapper {
  static WallpaperEntity fromMap(Map<String, dynamic> map) {
    return WallpaperEntity(
      imageOriginal: map['src']['original'],
      imageMedium: map['src']['medium'],
      extraLarge: map['src']['large2x'],
    );
  }
}
