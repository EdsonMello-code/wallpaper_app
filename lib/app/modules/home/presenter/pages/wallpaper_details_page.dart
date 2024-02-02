import 'package:flutter/material.dart';
import 'package:test_two/app/core/services/show_snackbar/show_snack_bar_impl.dart';
import 'package:test_two/app/core/widgets/image_widget.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_bloc.dart';
import 'package:test_two/app/modules/home/presenter/bloc/wallpaper_details/wallpaper_details_state.dart';
import 'package:wallpaper_design/custom_colors.dart';
import 'package:wallpaper_design/wallpaper_text.dart';

import '../bloc/wallpaper_details/wallpaper_details_event.dart';

class WallpaperDetailsPage extends StatefulWidget {
  final String url;
  final WallpaperDetailsBloc wallpaperDetailsbloc;

  const WallpaperDetailsPage({
    super.key,
    required this.url,
    required this.wallpaperDetailsbloc,
  });

  @override
  State<WallpaperDetailsPage> createState() => _WallpaperDetailsPageState();
}

class _WallpaperDetailsPageState extends State<WallpaperDetailsPage> {
  @override
  void initState() {
    super.initState();

    widget.wallpaperDetailsbloc.stream.listen((wallpaperDetailsState) {
      if (wallpaperDetailsState is WallpaperDetailsSuccessState) {
        if (mounted) {
          ShowSnackBarImpl.showSnackBarSuccess(
            context,
            message: 'Imagem salva',
          );
        }
      }
      if (wallpaperDetailsState is WallpaperDetailsFailureState) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ShowSnackBarImpl.showSnackBarFailure(
            context,
            message: 'Error ao salvar imagem.',
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          widget.wallpaperDetailsbloc.add(
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
        child: WallpaperText.bodyOne('Download'),
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
      body: ImageWidget(
        imageUrl: widget.url,
        fit: BoxFit.cover,
        size: Size(
          size.width,
          size.height,
        ),
      ),
    );
  }
}
