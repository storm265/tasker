import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
