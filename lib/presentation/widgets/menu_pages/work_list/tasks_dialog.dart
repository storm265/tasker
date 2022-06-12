import 'package:flutter/material.dart';

void showTasksDialog(BuildContext context) {
  final List<String> _items = [
    'Incomplete Tasks',
    'Completed Tasks',
    'All Tasks'
  ];
  Color _iconColor = Colors.white;
  bool _isClicked = false;
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        insetPadding: const EdgeInsets.only(left: 115, bottom: 450),
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 130,
          width: 228,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((_, index) {
              return StatefulBuilder(
                builder: (context, setState) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _isClicked = !_isClicked;
                        (_iconColor == Colors.white)
                            ? _iconColor = Colors.green
                            : _iconColor = Colors.white;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _items[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.done,
                            color: _iconColor,
                          ),
                        ],
                      ),
                    )),
              );
            }),
          ),
        ),
      );
    },
  );
}
