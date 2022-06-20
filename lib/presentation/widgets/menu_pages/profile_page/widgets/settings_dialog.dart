import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/auth_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

Future<void> showSettingsDialog(BuildContext context) async {
  final _signUpController = SignUpController();
  final List<String> _items = ['Change password', 'Sign out'];
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 140,
          width: 270,
          child: ListView.separated(
            separatorBuilder: (_, __) {
              return SizedBox(
                height: 2,
                width: 268,
                child: ColoredBox(
                  color: Colors.grey.withOpacity(0.3),
                ),
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: _items.length,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      break;
                    case 1:
                      await _signUpController.signOut(context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: Text(
                      _items[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}
