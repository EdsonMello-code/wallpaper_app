import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_two/app/core/services/show_snackbar/show_snack_bar_impl.dart';
import 'package:test_two/app/modules/home/domain/usecases/download_wallpaper_usecase.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_bloc.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_state.dart';
import 'package:wallpaper_design/wallpaper_design.dart';

import '../../../../core/services/http_client/http_client_dio_service_impl.dart';
import '../../../../core/services/local_path/local_path_provider_service_impl.dart';
import '../../../../core/services/permission/permission_service_impl.dart';
import '../../externals/datasources/wallpaper_datasource_impl.dart';
import '../../infra/repositories/wallpaper_repository_impl.dart';
import '../bloc/wallpaper_details/wallpaper_details_event.dart';

class WallpaperDetailsPage extends StatefulWidget {
  final String url;

  const WallpaperDetailsPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<WallpaperDetailsPage> createState() => _WallpaperDetailsPageState();
}

class _WallpaperDetailsPageState extends State<WallpaperDetailsPage> {
  late final WallpaperDetailsBloc wallpaperDetailsbloc;

  @override
  void initState() {
    super.initState();

    // wallpaperDetailsbloc = Modular;

    wallpaperDetailsbloc = WallpaperDetailsBloc(
      DownloadWallpaperUsecase(
        WallpaperRepositoryImpl(
          WallpaperDatasourceImpl(
            HttpClientDioServiceImpl(
              Dio(),
              'https://api.pexels.com/v1',
            ),
            LocalPathProviderServiceImpl(),
            PermissionServiceImpl(),
          ),
        ),
      ),
    );

    wallpaperDetailsbloc.stream.listen((wallpaperDetailsState) {
      if (wallpaperDetailsState is WallpaperDetailsSuccessState) {
        ShowSnackBarImpl.showSnackBarSuccess(
          context,
          message: 'Imagem salva',
        );
      }
      if (wallpaperDetailsState is WallpaperDetailsFailureState) {
        ShowSnackBarImpl.showSnackBarFailure(
          context,
          message: 'Error ao salvar imagem.',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: WallpaperText.bodyOne('Download'),
        onPressed: () {
          wallpaperDetailsbloc.add(
            SaveWallpaperEvent(
              widget.url,
            ),
          );
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            const Size(200, 60),
          ),
          backgroundColor: MaterialStateProperty.all(
            CustomColors.mainDarkColor,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: CustomColors.mainGreyColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Image.network(
          widget.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
