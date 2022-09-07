import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:todo2/presentation/widgets/common/add_photo_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

// class CustomCacheManager {
//   static const key = 'avatar';
//   static CacheManager instance = CacheManager(
//     Config(
//       key,
//       stalePeriod: const Duration(days: 999999),
//       maxNrOfCacheObjects: 20,
//       repo: JsonCacheInfoRepository(databaseName: key),
//     ),
//   );
// }

class CachedAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final Map<String, String> imageHeader;
  const CachedAvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.imageHeader,
  }) : super(key: key);
  final int maxSize = 64;
  @override
  Widget build(BuildContext context) {
    log('imageHeader: $imageHeader');
    log('imageUrl: $imageUrl');
    return SizedBox(
      width: double.parse(maxSize.toString()),
      height: double.parse(maxSize.toString()),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        httpHeaders: imageHeader,
        imageBuilder: (_, imageProvider) {
          return CircleAvatar(backgroundImage: imageProvider);
        },
        placeholder: ((context, url) => SizedBox(
              width: double.parse(maxSize.toString()),
              height: double.parse(maxSize.toString()),
              child: const CircleAvatar(
                backgroundColor: Color(0xffC4C4C4),
                child: addPhotoWidget,
              ),
            )),
        errorWidget: (_, url, error) {
          log('errorWidget error $error');
          return SizedBox(
            width: double.parse(maxSize.toString()),
            height: double.parse(maxSize.toString()),
            child: const CircleAvatar(
              backgroundColor: Color(0xffC4C4C4),
              child: addPhotoWidget,
            ),
          );
        },
      ),
    );
  }
}
