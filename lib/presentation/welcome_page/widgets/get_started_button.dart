import 'package:flutter/material.dart';

class GetStartedButtonWidget extends StatelessWidget {
  final double width;
  const GetStartedButtonWidget({Key? key, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width * 0.125,
      top: 550,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            fixedSize: MaterialStateProperty.all(const Size(300, 50))),
        onPressed: () => Navigator.pushNamed(context, '/signUp'),
        child: const Text(
          'Get started',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
