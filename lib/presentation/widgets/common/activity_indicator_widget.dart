import 'package:flutter/cupertino.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class ActivityIndicatorWidget extends StatelessWidget {
  final String? text;
  const ActivityIndicatorWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(
          color: Palette.red,
        ),
        text == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text!,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
      ],
    );
  }
}
