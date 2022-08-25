import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopWrap(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.wifi,
                size: 60,
                color: Colors.red,
              ),
              Text(
                'Connect to internet',
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
