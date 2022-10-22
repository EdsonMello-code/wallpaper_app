import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/core/services/http_client/http_client_dio_service_impl.dart';
import 'package:test_two/app/core/services/local_path/local_path_provider_service_impl.dart';
import 'package:test_two/app/core/services/permission/permission_service_impl.dart';
import 'package:test_two/app/modules/home/domain/usecases/get_wallpapers_usecase.dart';
import 'package:test_two/app/modules/home/externals/datasources/wallpaper_datasource_impl.dart';
import 'package:test_two/app/modules/home/infra/repositories/wallpaper_repository_impl.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpapers/wallpapers_state.dart';
import 'package:wallpaper_design/wallpaper_design.dart';

import '../../domain/usecases/get_wallpapers_by_subject_usecase.dart';
import '../bloc/wallpapers/wallpaper_bloc.dart';
import '../bloc/wallpapers/wallpaper_event.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({Key? key}) : super(key: key);

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  late final TextEditingController _wallpaperTextEditingController;

  late final WallpaperBloc wallpaperbloc;

  @override
  void initState() {
    super.initState();

    wallpaperbloc = WallpaperBloc(
      GetWallpapersUsecase(
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
      GetWallpapersBySubjectUsecase(
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
    wallpaperbloc.add(GetWallpaperEvent());
    _wallpaperTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainDarkColor,
      appBar: CustomAppBarComponent(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 44.0,
                  bottom: 44.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WallpaperText.headline('Wallpaper'),
                    Image.asset(
                      'assets/icons/menu.png',
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: CustomTextFieldComponent(
                  hintText: 'Pesquisar',
                  textFieldController: _wallpaperTextEditingController,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      wallpaperbloc.add(
                        GetWallpaperBySubjectEvent(
                          subject: _wallpaperTextEditingController.text,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Icon(
                        Icons.search,
                        color: CustomColors.mainGreyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WallpaperBloc, WallpapersState>(
          bloc: wallpaperbloc,
          builder: (context, state) {
            if (state is WallpaperLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is WallpapperFailureState) {
              return Center(
                child: WallpaperText.bodyOne(
                  state.message,
                ),
              );
            }

            if (state is WallpaperSuccessState) {
              final wallpapers = state.wallpapers;

              return GridView.builder(
                itemCount: wallpapers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Modular.to.pushNamed(
                          '/wallpaper_details/',
                          arguments: wallpapers[index].extraLarge,
                        );
                      },
                      child: Image.network(
                        wallpapers[index].extraLarge,
                        fit: BoxFit.cover,
                        cacheHeight: 200,
                        cacheWidth: 200,
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
      // body: ,
    );
  }
}
