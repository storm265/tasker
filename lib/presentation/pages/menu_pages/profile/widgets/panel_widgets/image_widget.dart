import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedAvatarWidget extends StatelessWidget {
  final String image;
  final double radius;

  const CachedAvatarWidget({Key? key, required this.image, this.radius = 70})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CachedNetworkImage(
      memCacheHeight: 300,
      memCacheWidth: 300,
      maxWidthDiskCache: 300,
      maxHeightDiskCache: 300,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: 10,
            backgroundImage: imageProvider,
          );
        },
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageUrl: image,
      ),
    );
  }
}
