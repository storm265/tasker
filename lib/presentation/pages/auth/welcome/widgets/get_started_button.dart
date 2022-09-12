import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/wave_colors.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class GetStartedButton extends StatelessWidget {
  final int pageIndex;
  const GetStartedButton({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: InkWell(
          onTap: () async =>
              await NavigationService.navigateTo(context, Pages.signUp),
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: waveColors[pageIndex],
                  blurRadius: 10,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
