import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/core/services/http_client/http_client_service.dart';
import 'package:test_two/app/core/services/http_client/http_client_uno_service.dart';
import 'package:test_two/app/core/services/local_path/local_path_provider_service_impl.dart';
import 'package:test_two/app/core/services/local_path/local_path_service.dart';
import 'package:test_two/app/core/services/local_storage/hive_local_storage.dart';
import 'package:test_two/app/core/services/local_storage/local_storage.dart';
import 'package:test_two/app/core/services/permission/permission_service.dart';
import 'package:test_two/app/core/services/permission/permission_service_impl.dart';
import 'package:test_two/app/modules/home/domain/repositories/wallpaper_repository.dart';
import 'package:test_two/app/modules/home/domain/usecases/download_wallpaper_usecase.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_usecase.dart';
import 'package:test_two/app/modules/home/externals/datasources/wallpaper_datasource_impl.dart';
import 'package:test_two/app/modules/home/externals/datasources/wallpaper_offline_datasource_impl.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_datasource.dart';
import 'package:test_two/app/modules/home/infra/datasources/wallpaper_offline_datasource.dart';
import 'package:test_two/app/modules/home/infra/repositories/wallpaper_repository_impl.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_bloc.dart';
import 'package:test_two/app/modules/home/presenter/pages/wallpaper_details_page.dart';

import 'domain/usecases/get_wallpapers_by_subject_usecase.dart';
import 'presenter/bloc/wallpapers/wallpaper_bloc.dart';
import 'presenter/pages/wallpaper_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      WallpaperBloc.new,
    );
    i.addLazySingleton(
      WallpaperDetailsBloc.new,
    );

    i.addLazySingleton<IGetWallpapersUsecase>(
      GetWallpapersUsecase.new,
    );

    i.addLazySingleton<IGetWallpapersBySubjectUsecase>(
      GetWallpapersBySubjectUsecase.new,
    );

    i.addLazySingleton<IDownloadWallpaperUsecase>(
      DownloadWallpaperUsecase.new,
    );

    i.addLazySingleton<WallpaperRepository>(
      WallpaperRepositoryImpl.new,
    );

    i.addLazySingleton<WallpapperOfflineDatasource>(
      WallpapperOfflineDatasourceImpl.new,
    );

    i.addLazySingleton<WallpaperDatasource>(
      WallpaperDatasourceImpl.new,
    );
    i.addLazySingleton<PermissionService>(
      PermissionServiceImpl.new,
    );
    i.addLazySingleton<LocalPathService>(
      LocalPathProviderServiceImpl.new,
    );
    i.addLazySingleton<HttpClientService>(
      HttpClientUnoServiceImpl.new,
    );
    i.add<LocalStorage>(
      () => const HiveLocalStorage('wallpaper'),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => WallpaperPage(
        wallpaperbloc: Modular.get(),
      ),
    );

    r.child(
      '/wallpaper_details/',
      child: (context) => WallpaperDetailsPage(
        url: r.args.data,
        wallpaperDetailsbloc: Modular.get(),
      ),
    );
  }
}
