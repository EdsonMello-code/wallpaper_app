import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Size size;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.size = const Size(24, 24),
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      memCacheHeight: size.height.toInt(),
      memCacheWidth: size.width.toInt(),
    );
  }
}
