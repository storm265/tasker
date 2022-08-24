import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/add_photo_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class CachedAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final Map<String, String> imageHeader;

  const CachedAvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.imageHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      memCacheHeight: 300,
      memCacheWidth: 300,
      maxWidthDiskCache: 300,
      maxHeightDiskCache: 300,
      height: 64,
      width: 64,
      progressIndicatorBuilder: (context, url, progress) {
        log('progress : ${progress.progress}');
        return ProgressIndicatorWidget(
            text:
                '${progress.progress == null ? 0 : progress.progress!.ceilToDouble() * 100}%');
      },
      imageBuilder: (_, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ),
      errorWidget: (_, url, error) => const CircleAvatar(
        backgroundColor: Color(0xffC4C4C4),
        child: addPhotoWidget,
      ),
      imageUrl: imageUrl,
      httpHeaders: imageHeader,
    );
  }
}
