import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/core/services/http_client/http_client_uno_service.dart';
import 'package:test_two/app/core/services/local_path/local_path_provider_service_impl.dart';
import 'package:test_two/app/core/services/local_storage/hive_local_storage.dart';
import 'package:test_two/app/core/services/local_storage/local_storage.dart';
import 'package:test_two/app/core/services/permission/permission_service_impl.dart';
import 'package:test_two/app/modules/home/domain/usecases/download_wallpaper_usecase.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_usecase.dart';
import 'package:test_two/app/modules/home/externals/datasources/wallpaper_datasource_impl.dart';
import 'package:test_two/app/modules/home/externals/datasources/wallpaper_offline_datasource_impl.dart';
import 'package:test_two/app/modules/home/infra/repositories/wallpaper_repository_impl.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_bloc.dart';
import 'package:test_two/app/modules/home/presenter/pages/wallpaper_details_page.dart';

import 'domain/usecases/get_wallpapers_by_subject_usecase.dart';
import 'presenter/bloc/wallpapers/wallpaper_bloc.dart';
import 'presenter/pages/wallpaper_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> binds = [
    Bind.lazySingleton(
      (i) => WallpaperBloc(
        i(),
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetWallpapersUsecase(
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => WallpapperOfflineDatasourceImpl(i()),
    ),
    Bind.lazySingleton<LocalStorage>(
      (i) => const HiveLocalStorage('wallpaper'),
    ),
    Bind.lazySingleton(
      (i) => GetWallpapersBySubjectUsecase(
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => WallpaperRepositoryImpl(
        i(),
        i(),
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => WallpaperDatasourceImpl(
        i(),
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => DownloadWallpaperUsecase(
        i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => PermissionServiceImpl(),
    ),
    Bind.lazySingleton(
      (i) => LocalPathProviderServiceImpl(),
    ),
    Bind.lazySingleton(
      (i) => HttpClientUnoServiceImpl(
        uno: i(),
      ),
    ),
    Bind.lazySingleton(
      (i) => WallpaperDetailsBloc(i()),
    )
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, _) => WallpaperPage(
        wallpaperbloc: Modular.get(),
      ),
    ),
    ChildRoute(
      '/wallpaper_details/',
      child: (context, args) => WallpaperDetailsPage(
        url: args.data,
        wallpaperDetailsbloc: Modular.get(),
      ),
    )
  ];
}
