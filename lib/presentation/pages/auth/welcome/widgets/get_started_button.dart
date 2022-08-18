import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class GetStartedButton extends StatelessWidget {
  final int pageIndex;
  GetStartedButton({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  final List<Color> shadowColor = [
    const Color(0xFFC84444),
    const Color(0xFF4C62F1),
    const Color(0xFF754BF8),
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: InkWell(
          onTap: () => NavigationService.navigateTo(context, Pages.signUp),
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: shadowColor[pageIndex],
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
