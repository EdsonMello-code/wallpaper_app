abstract class WallpaperEvent {}

class GetWallpaperEvent implements WallpaperEvent {}

class GetWallpaperBySubjectEvent implements WallpaperEvent {
  final String subject;

  const GetWallpaperBySubjectEvent({
    required this.subject,
  });
}
