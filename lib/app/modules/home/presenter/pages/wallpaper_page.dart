import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_two/app/core/mixins/navigation_service.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpapers/wallpapers_state.dart';
import 'package:wallpaper_design/wallpaper_design.dart';

import '../bloc/wallpapers/wallpaper_bloc.dart';
import '../bloc/wallpapers/wallpaper_event.dart';

class WallpaperPage extends StatefulWidget {
  final WallpaperBloc wallpaperbloc;

  const WallpaperPage({
    Key? key,
    required this.wallpaperbloc,
  }) : super(key: key);

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> with NavigationMixin {
  late final TextEditingController _wallpaperTextEditingController;

  @override
  void initState() {
    super.initState();

    widget.wallpaperbloc.add(GetWallpaperEvent());
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
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomTextFieldComponent(
                  hintText: 'Pesquisar',
                  textFieldController: _wallpaperTextEditingController,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      widget.wallpaperbloc.add(
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<WallpaperBloc, WallpapersState>(
          bloc: widget.wallpaperbloc,
          builder: (context, state) {
            return switch (state) {
              WallpaperLoadingState _ => const Center(
                  child: CircularProgressIndicator(),
                ),
              WallpapperFailureState _ => Center(
                  child: WallpaperText.bodyOne(
                    state.message,
                  ),
                ),
              WallpaperStartState _ => Container(),
              WallpaperSuccessState state => GridView.builder(
                  itemCount: state.wallpapers.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final wallpaper = state.wallpapers[index];

                    return Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          pushNamed(
                            '/wallpaper_details/',
                            arguments: wallpaper.extraLarge,
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: wallpaper.extraLarge,
                          fit: BoxFit.cover,
                          memCacheHeight: 200,
                          memCacheWidth: 200,
                        ),
                      ),
                    );
                  },
                )
            };
          },
        ),
      ),
    );
  }
}
