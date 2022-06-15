import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_event.dart';

import '../../../domain/usecases/download_wallpaper_usecase.dart';
import 'wallpaper_details_state.dart';

class WallpaperDetailsBloc
    extends Bloc<WallpaperDetailsEvent, WallpaperDetailsState> {
  final DownloadWallpaperUsecase _downloadWallpaperUsecase;

  WallpaperDetailsBloc(this._downloadWallpaperUsecase)
      : super(
          WallpaperDetailsStartState(),
        ) {
    on<SaveWallpaperEvent>(downloadWallpaper);
  }

  Future<void> downloadWallpaper(
    SaveWallpaperEvent downloadWallpperEvent,
    emit,
  ) async {
    emit(WallpaperDetailsLoadingState());

    final isSavedWallpaper = await _downloadWallpaperUsecase(
      downloadWallpperEvent.url,
    );

    isSavedWallpaper.fold((leftWallpaper) {
      emit(WallpaperDetailsFailureState());

      log(leftWallpaper.message);
    }, (rightWallpaper) {
      emit(WallpaperDetailsSuccessState());
      log(rightWallpaper.toString());
    });
  }
}
