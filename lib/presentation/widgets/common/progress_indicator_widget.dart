import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final String? text;
  const ProgressIndicatorWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitDualRing(
          size: 30,
          color: Theme.of(context).primaryColor,
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
