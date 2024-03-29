import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_usecase.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpapers/wallpaper_event.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpapers/wallpapers_state.dart';

import '../../../domain/usecases/get_wallpapers_by_subject_usecase.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpapersState> {
  final IGetWallpapersUsecase _getWallpapersUsecase;
  final IGetWallpapersBySubjectUsecase _getWallpapersBySujectUsecase;

  WallpaperBloc(
    this._getWallpapersUsecase,
    this._getWallpapersBySujectUsecase,
  ) : super(WallpaperStartState()) {
    on<GetWallpaperEvent>(loadWallpapers);
    on<GetWallpaperBySubjectEvent>(loadWallpapersBySubject);
  }

  Future<void> loadWallpapers(
    GetWallpaperEvent wallpaperEvent,
    emit,
  ) async {
    emit(WallpaperLoadingState());

    final responseWallpapers = await _getWallpapersUsecase();

    responseWallpapers.fold(left: (leftWallpaper) {
      emit(
        WallpapperFailureState(
          message: leftWallpaper.message,
        ),
      );
    }, right: (rightWallpaper) {
      emit(
        WallpaperSuccessState(
          wallpapers: rightWallpaper,
        ),
      );
    });
  }

  Future<void> loadWallpapersBySubject(
    GetWallpaperBySubjectEvent getWallpaperBySubjectEvent,
    emit,
  ) async {
    emit(WallpaperLoadingState());

    final responseWallpapers =
        await _getWallpapersBySujectUsecase(getWallpaperBySubjectEvent.subject);

    responseWallpapers.fold(left: (leftWallpaper) {
      emit(
        WallpapperFailureState(
          message: leftWallpaper.message,
        ),
      );
    }, right: (rightWallpaper) {
      emit(
        WallpaperSuccessState(
          wallpapers: rightWallpaper,
        ),
      );
    });
  }
}
