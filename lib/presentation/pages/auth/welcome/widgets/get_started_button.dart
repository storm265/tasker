import 'package:flutter/material.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            fixedSize: MaterialStateProperty.all(
              const Size(300, 50),
            ),
          ),
          onPressed: () => NavigationService.navigateTo(context, Pages.signUp),
          child: const Text(
            'Get started',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
