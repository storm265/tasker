import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/widgets/common/add_photo_widget.dart';

class CachedAvatarWidget extends StatelessWidget {
  final ProfileController profileController;
  const CachedAvatarWidget({
    Key? key,
    required this.profileController,
  }) : super(key: key);
  final int maxSize = 64;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.parse(maxSize.toString()),
      height: double.parse(maxSize.toString()),
      child: ValueListenableBuilder<String>(
        valueListenable: profileController.imageUrl,
        builder: (__, url, _) => url.isEmpty
            ? const CircleAvatar(
                backgroundColor: Color(0xffC4C4C4),
                child: addPhotoWidget,
              )
            : CachedNetworkImage(
                //cacheKey: '0',
                imageUrl: url,
                httpHeaders: profileController.imageHeader,
                imageBuilder: (_, imageProvider) {
                  return CircleAvatar(backgroundImage: imageProvider);
                },
                placeholder: ((_, url) => SizedBox(
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
      ),
    );
  }
}
