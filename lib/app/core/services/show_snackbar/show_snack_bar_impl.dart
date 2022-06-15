import 'package:flutter/material.dart';
import 'package:wallpaper_design/wallpaper_design.dart';

class ShowSnackBarImpl {
  static void showSnackBarFailure(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: WallpaperText.snackBarText(message),
      ),
    );
  }

  static void showSnackBarSuccess(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: WallpaperText.snackBarText(message),
      ),
    );
  }
}
