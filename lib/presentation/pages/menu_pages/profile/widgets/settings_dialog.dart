import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/auth_controller.dart';


Future<void> showSettingsDialog(BuildContext context) async {
  final signUpController = SignUpController();
  final List<String> items = ['Change password', 'Sign out'];
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
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return GestureDetector(
                onTap: () async {
                  switch (index) {
                    case 0:
                      break;
                    case 1:
                      await signUpController.signOut(context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  child: Center(
                    child: Text(
                      items[index],
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
