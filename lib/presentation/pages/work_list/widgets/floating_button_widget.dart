import 'package:flutter/material.dart';
import 'package:todo2/services/supabase/configure.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => supabase.auth
          .signOut()
          .then((_) => Navigator.pushReplacementNamed(context, '/signIn'))),
      child: Container(
          width: 56,
          height: 56,
          child: const Icon(Icons.add, color: Colors.white),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF96060), Color(0xFFF96060)]),
              shape: BoxShape.circle)),
    );
  }
}
