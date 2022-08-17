import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class CachedAvatarWidget extends StatelessWidget {
  final String image;
  final double radius;

  const CachedAvatarWidget({
    Key? key,
    required this.image,
    this.radius = 70,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log('CachedAvatarWidget image $image');
    return SizedBox(
      width: radius,
      height: radius,
      child: CachedNetworkImage(
        memCacheHeight: 300,
        memCacheWidth: 300,
        maxWidthDiskCache: 300,
        maxHeightDiskCache: 300,
        progressIndicatorBuilder: (context, url, progress) =>
            const ProgressIndicatorWidget(),
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 10,
          backgroundImage: imageProvider,
        ),
        errorWidget: (_, url, error) => const Icon(Icons.error),
        imageUrl: image,
      ),
    );
  }
}
