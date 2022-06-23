// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';

import '../shared/utils.dart' show CalendarFormat;

class IconOpener extends StatefulWidget {
  final ValueChanged<CalendarFormat> onTap;

  const IconOpener({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<IconOpener> createState() => _IconOpenerState();
}

class _IconOpenerState extends State<IconOpener> {
  bool _isMonth = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => GestureDetector(
        onTap: () => setState(() => isShowMonth()),
        child: const Icon(
          Icons.expand_more,
        ),
      ),
    );
  }

  void isShowMonth() {
    _isMonth = !_isMonth;
    widget.onTap(_isMonth ? CalendarFormat.month : CalendarFormat.week);
  }
}
