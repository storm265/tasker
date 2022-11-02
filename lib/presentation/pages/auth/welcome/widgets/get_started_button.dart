import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

const List<Color> _shadowColor = [
  Color(0xFFC84444),
  Color(0xFF4C62F1),
  Color(0xFF754BF8),
];

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
                  color: _shadowColor[pageIndex],
                  blurRadius: 10,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleKeys.get_started.tr(),
                style: const TextStyle(
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
