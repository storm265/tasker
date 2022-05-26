import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        width: 350,
        height: 200,
        child: Stack(
          children: [
            Positioned(
                left: 290,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.settings))),
            Positioned(
              top: 40,
              child: SizedBox(
                width: 300,
                height: 70,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                  ),
                  title: Text('dadoada'),
                  subtitle: FittedBox(child: Text('pangcheo1210@gmail.com')),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('120'),
                  Text('Create Tasks'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
