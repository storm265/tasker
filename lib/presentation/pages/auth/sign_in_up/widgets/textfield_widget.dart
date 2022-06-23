import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String text, labelText;
  final double left, top;
  final bool isObsecureText;
  final Function(String? text)? validateCallback;
  const TextFieldWidget(
      {Key? key,
      required this.left,
      required this.validateCallback,
      required this.top,
      required this.labelText,
      required this.textController,
      required this.text,
      required this.isObsecureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 350,
            height: 50,
            child: TextFormField(
              validator: (value) => validateCallback!(value),
              obscureText: isObsecureText,
              controller: textController,
              decoration: InputDecoration(hintText: labelText),
            ),
          ),
        ],
      ),
    );
  }
}
