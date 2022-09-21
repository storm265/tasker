import 'package:flutter/material.dart';

Future<void> pickTime({required BuildContext context}) async {
  TimeOfDay? pickedTime = await showTimePicker(
   
    initialTime: TimeOfDay.now(),
    context: context,
  );
  print(pickedTime);
}
