import 'package:flutter/material.dart';

class DetailedTitleWidget extends StatefulWidget {
  final String title;
  const DetailedTitleWidget({
    super.key,
    required this.title,
  });

  @override
  State<DetailedTitleWidget> createState() => _DetailedTitleWidgetState();
}

class _DetailedTitleWidgetState extends State<DetailedTitleWidget> {
  late final TextEditingController _title;

  @override
  void initState() {
    _title = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextField(
        decoration: const InputDecoration(border: InputBorder.none),
        maxLines: null,
        enabled: false,
        controller: _title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
