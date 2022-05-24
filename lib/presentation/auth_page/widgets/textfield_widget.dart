import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Size size;
  final TextEditingController textController;
  final String text, labelText;
  final double left, top;
  final bool isObsecureText;
  const TextFieldWidget(
      {Key? key,
      required this.left,
      required this.size,
      required this.top,
      required this.labelText,
      required this.textController,
      required this.text,
      required this.isObsecureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: size.width * left,
        top: size.height * top,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(text, style: const TextStyle(fontSize: 20, color: Colors.black)),
          SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                  obscureText: isObsecureText,
                  controller: textController,
                  decoration: InputDecoration(labelText: labelText)))
        ]));
  }
}
