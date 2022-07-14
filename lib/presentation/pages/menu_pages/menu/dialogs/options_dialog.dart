import 'package:flutter/material.dart';

Future<void> showOptionsDialog(BuildContext context) async {
  final icons = [Icons.edit, Icons.delete];
  final titles = ['Edit', 'Remove'];
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: 70,
        height: 100,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    icons[index],
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(titles[index]),
                ),
              )),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
