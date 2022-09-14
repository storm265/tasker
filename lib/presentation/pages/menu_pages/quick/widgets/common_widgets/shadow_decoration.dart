import 'package:flutter/material.dart';

final shadowDecoration = BoxDecoration(color: Colors.white, boxShadow: [
  BoxShadow(
    color: const Color(0xFFE0E0E0).withOpacity(0.5),
    offset: const Offset(5, 5),
    blurRadius: 9,
  )
]);
