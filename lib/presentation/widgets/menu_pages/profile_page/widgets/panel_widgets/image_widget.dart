import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedAvatarWidget extends StatelessWidget {
  const CachedAvatarWidget({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: CachedNetworkImage(
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
